extends CenterContainer

# This is highly unorthodox and should be fixed, as there is no way to use this system with multiple inventories
var inventory = preload("res://inventory/Inventory.tres")

@onready var item_texture_rect = $ItemTextureRect

func display_item(item):
	item_texture_rect.texture = (
		item.texture if item is Item
		else load("res://inventory/empty.png")
	)

func _get_drag_data(_at_position: Vector2):
	var item_index = get_index()
	var item = inventory.remove_item(item_index)
	if item is Item:
		var data := {}
		data.item = item
		data.item_index = item_index
		var drag_preview = TextureRect.new()
		drag_preview.texture = item.texture
		set_drag_preview(drag_preview)
		return data

func _can_drop_data(at_position, data):
	return data is Dictionary && data.has("item")
	pass

func _drop_data(at_position, data):
	pass