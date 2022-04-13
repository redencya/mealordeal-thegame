extends Resource
class_name Inventory

signal items_changed(indexes: Array[int])

@export var items : Array = []
# Ideally, it should be refactored to work with multiple Inventories, as opposed to being restricted to a single Inventory.

func set_item(item_index: int, item: Item) -> Item:
  var item_previous = items[item_index]
  items[item_index] = item
  emit_signal("items_changed", [item_index])
  return item_previous

func swap_items(item_index: int, target_item_index: int) -> void:
  var target_item = items[target_item_index]
  var item = items[item_index]
  items[target_item_index] = item
  items[item_index] = target_item
  emit_signal("items_changed", [item_index, target_item_index])

func remove_item(item_index: int) -> Item:
  var item_previous = items[item_index]
  items[item_index] = null
  emit_signal("items_changed", [item_index])
  return item_previous
