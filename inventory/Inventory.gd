extends Resource
class_name Inventory

signal inventory_changed

@export var _items : Array = Array():
	get:
		return _items
	set(new_items):
		_items = new_items

func get_item(index: int):
	if index >= _items.size(): return null
	return _items[index]
	
func add_item(item_name: String, quantity: int) -> void:
	if quantity <= 0: return
# @home: Remove the new() and make ItemDB a singleton
	var item : Item = ItemDatabase.get_item(item_name)
	if !is_instance_valid(item):
		return
		
	var remaining_quantity := quantity
	var max_stack_size := item.max_stack_size if item.stackable else 1
	
	if item.stackable:
		for i in range(_items.size()):
			if remaining_quantity == 0: break
			
			var inventory_item = _items[i]
			if inventory_item.item_reference.name != item_name: continue
			
			if inventory_item.quantity < max_stack_size:
				var original_quantity = inventory_item.quantity
				inventory_item.quantity = min(
					original_quantity + remaining_quantity,
					max_stack_size
				)
				remaining_quantity -= (inventory_item.quantity - original_quantity)
				
	while(remaining_quantity > 0):
		var new_item : Dictionary = {
			item_reference = item,
			quantity = min(remaining_quantity, max_stack_size)
		}
		_items.append(new_item)
		remaining_quantity -= new_item.quantity

	emit_signal("inventory_changed")
