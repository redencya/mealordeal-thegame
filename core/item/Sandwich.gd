extends Item
class_name Sandwich

@export var requirements : Array[Dictionary]
	
func hydrate(values: Array[Dictionary]):
	for value in values:
		value.item_reference = ItemDatabase.get_item(value.item_reference)
		value.quantity

@export var sell_value : int
@export var heal_value : int
