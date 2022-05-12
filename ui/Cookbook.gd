extends PanelContainer

signal sandwich_changed

@onready var requirement_display = preload("res://ui/RequirementPanel.tscn")
@export var inventory_ref : Resource
@onready var inventory = inventory_ref as Inventory

var sandwiches : Array[Sandwich] = ItemDatabase.items.filter(get_sandwiches)
var current_sandwich : Sandwich = sandwiches[0]:
	set(v): 
		current_sandwich = (v)
		emit_signal("sandwich_changed")

func get_sandwiches(items):
	return items is Sandwich

func _ready():
	inventory.connect("inventory_changed", _on_inventory_changed)
	connect("sandwich_changed", _on_sandwich_changed)

#render_requirements(current_sandwich.requirements)

func render_requirement(requirement: Dictionary) -> void:
	var req : RequirementDisplay = requirement_display.instantiate()
	req.set_color(
		inventory.validate_item_request(requirement)
	)
	req.set_data(
		requirement.item_reference.name,
		inventory.get_largest_instance(requirement.item_reference).quantity,
		requirement.quantity
	)
	$Requirements.add_child(req)

func render_requirements(requirements: Array[Dictionary]) -> void:
	if $Requirements.get_children().size() > 0:
		for i in $Requirements.get_children().size():
			$Requirements.remove_child(i)

	for requirement in requirements:
		render_requirement(requirement)

func update_crafting_status() -> bool:
	return inventory.validate_order(current_sandwich.requirements)

func _on_create_sandwich_pressed():
	for requirement in current_sandwich.requirements:
		inventory.remove_item(requirement)

func _on_sandwich_changed():
	render_requirements(current_sandwich.requirements)
	update_crafting_status()

func _on_inventory_changed():
	#render_requirements(current_sandwich.requirements)
	#update_crafting_status()
	pass