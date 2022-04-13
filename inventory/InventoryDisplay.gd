extends GridContainer

var inventory = preload("res://inventory/Inventory.tres")

func _ready():
	inventory.connect("items_changed", _on_items_changed)
	call_deferred("update_inventory_display")

func update_inventory_display():
	print("update_inventory_display works")
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)

func update_inventory_slot_display(item_index: int) -> void:
	print("update_inventory_slot_display works")
	var inventory_slot_display = get_child(item_index)
	var item = inventory.items[item_index]
	inventory_slot_display.display_item(item)

func _on_items_changed(indexes: Array[int]):
	for item_index in indexes:
		update_inventory_slot_display(item_index)