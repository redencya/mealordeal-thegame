# The Storage class is a collection of Cells which contain Item data. It's used to manage states of items between multiple environments.
# 
# The class finds most use in player inventories, but it is also used to determine the drops of mobs and props, as well as contents of specific chests. 
extends Resource
class_name Storage, "res://svg/storage.svg"

signal items_changed(indexes: Array[int])

@export var items : Array[Resource]
@export var dimensions : Vector2i

func set_item(i : int, item : Item) -> Item:
	var previous_item = items[i]
	items[i] = item
	emit_signal("items_changed", [i])
	return previous_item