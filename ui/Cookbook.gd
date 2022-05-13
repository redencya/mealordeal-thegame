extends PanelContainer

signal sandwich_changed

@onready var requirement_display = preload("res://ui/RequirementPanel.tscn")
@export var inventory_ref : Resource
@onready var inventory = inventory_ref as Inventory

var sandwiches : Array[Sandwich] = ItemDatabase.items.filter(func(sandwich): return sandwich is Sandwich)
var current_sandwich : Sandwich = sandwiches[0]:
	set(v): 
		current_sandwich = (v)
		emit_signal("sandwich_changed")

func _ready():
	current_sandwich.hydrate(current_sandwich.requirements)
	inventory.connect("inventory_changed", _on_inventory_changed)
	connect("sandwich_changed", _on_sandwich_changed)
	$VBoxContainer/CreateSandwich.set_disabled(!inventory.validate_order(current_sandwich.requirements))
	render_requirements(current_sandwich.requirements)

func render_requirement(requirement: Dictionary) -> void:
	var display : RequirementDisplay = requirement_display.instantiate()
	display.set_color(
		inventory.validate_item_request(requirement)
	)
	display.set_data(
		requirement.item_reference.name,
		inventory.get_largest_instance(requirement.item_reference).quantity,
		requirement.quantity
	)
	$VBoxContainer/Contents/Requirements.add_child(display)

func render_requirements(requirements: Array[Dictionary]) -> void:
	if $VBoxContainer/Contents/Requirements.get_children().size() > 0:
		for child in $VBoxContainer/Contents/Requirements.get_children():
			child.queue_free()
	for requirement in requirements:
		render_requirement(requirement)

func _on_create_sandwich_pressed():
	for requirement in current_sandwich.requirements:
		inventory.remove_item(requirement)
	inventory.add_item(current_sandwich.name, 1)

func _on_sandwich_changed():
	current_sandwich.hydrate(current_sandwich.requirements)
	render_requirements(current_sandwich.requirements)
	$VBoxContainer/CreateSandwich.set_disabled(!inventory.validate_order(current_sandwich.requirements))

func _on_inventory_changed():
	print(inventory._items)
	render_requirements(current_sandwich.requirements)
	$VBoxContainer/CreateSandwich.set_disabled(!inventory.validate_order(current_sandwich.requirements))
	print(!inventory.validate_order(current_sandwich.requirements), $VBoxContainer/CreateSandwich.is_disabled())
