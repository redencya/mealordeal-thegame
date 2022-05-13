extends Control

@export var inventory_reference : Resource
@onready var inventory = inventory_reference as Inventory
@onready var displays = $ItemDisplayContainer.get_children()

func clear_display():
	for display in displays:
		display.reset()

func render_display():
	for display in displays:
		var current_item = inventory.get_item(display.get_index())
		if current_item != null:
			display.populate(current_item.item_reference.texture, current_item.quantity)

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.connect("inventory_changed", _on_inventory_changed)
	
func _on_inventory_changed() -> void:
	clear_display()
	render_display()

# [
# 	{
# 		"item_reference":[Resource:-9223372010850089849], 
# 		"quantity":2
# 	}, 
# 	{
# 		"item_reference":[Resource:-9223372010850089849], 
# 		"quantity":8
# 	}, 
# 	{
# 		"item_reference":[Resource:-9223372011672173443],
# 		"quantity":7
# 	}, 
# 	{
# 		"item_reference":[Resource:-9223372011672173443],
# 	  "quantity":8
# 	}, 
# 	{
# 		"item_reference":[Resource:-9223372011252743039],
# 		"quantity":5
# 	}
# ]
