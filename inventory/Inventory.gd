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

func pool_valid_items(item_reference : Item) -> Array[Dictionary]:
	var pool : Array[Dictionary] = []
	for item in _items:
		if item.item_reference == item_reference:
			pool.append(item) 
	return pool

func get_largest_instance(item_reference : Item) -> Dictionary:
	var current_largest := {
		item_reference = item_reference,
		quantity = 0
	}
	var pool := pool_valid_items(item_reference)
	if pool.size() < 1:
		return current_largest
	for item in pool:
		if (current_largest == null 
			|| item.quantity > current_largest.quantity):
				current_largest = item
	return current_largest

func validate_item_request(item_request: Dictionary) -> bool:
	var pool : Array[Dictionary] = pool_valid_items(item_request.item_reference)
	if pool.size() < 1: return false
	for item in pool:
		if item.quantity >= item_request.quantity:
			return true
	return false

func validate_order(request: Array[Dictionary]) -> bool:
	for index in request:
		if !validate_item_request(index):
			return false
	return true

func remove_item(request: Dictionary) -> void:
	var largest_valid_item = get_largest_instance(request.item_reference)
	largest_valid_item.quantity -= request.quantity
	if largest_valid_item.quantity <= 0:
		_items.erase(largest_valid_item)
	emit_signal("inventory_changed")

func add_item(item_name: String, quantity: int) -> void:
	if quantity <= 0: return
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
