extends Control

@export var inventory_reference : Resource

func render_display():
	var items_container = $ItemDisplayContainer
	for item_display in items_container.get_children():
		var i = item_display.get_index()
		var item = inventory_reference.get_item(i)
		if item != null:
			item_display.populate(
				item.get("item_reference").texture, 
				item.get("quantity"))

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_reference.connect("inventory_changed", _on_inventory_changed)
	
func _on_inventory_changed() -> void:
	render_display()
