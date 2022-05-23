# The entire premise of the inventory is to provide render data and information for crafting operations.
# It stores the item references with quantities as key/value pairs. 

# The inventory can be used to remove or add items to itself. 

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
	
# This method is used to narrow down the inventory to a single item type.
# It exists to serve as a nice bit of abstraction for isolating the relevant elements, 
# but there's nothing that would stop it from being a part of a larger anonymous function.
func pool_valid_items(item_reference : Item) -> Array[Dictionary]:
	var pool : Array[Dictionary] = _items.filter(
		func(item): return item.item_reference == item_reference)
	return pool

# Sice the player can't physically drag items from the inventory to use them in crafting,
# The code has to provide a reference itself.
func get_largest_instance(item_reference : Item) -> Dictionary:
	var pool := pool_valid_items(item_reference)
	if pool.size() < 1:
		return {
			item_reference = item_reference,
			quantity = 0
		}
	pool.sort_custom(func(a, b): return a.quantity < b.quantity)
	return pool[0]

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
