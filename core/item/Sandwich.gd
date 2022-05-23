# Sandwiches exist as a way to distinguish craftable items from primary items. 
# Generally speaking it would be more orthodox to use an ID-based system for assiging the parents, 
# but I found myself more comfortable with a dictionary of descriptive key-value pairs.

extends Item
class_name Sandwich

# Think of this as a list of nodes that lead directly to this node. 
# In hindsight, this should've been on the item base, since it'd just have an empty array here, but it's too late to fix it now.
@export var requirements : Array[Dictionary]

# This function is a MASSIVE band-aid fix. Normally there should be no reason to do what I'm doing here,
# But because Godot continues to lack custom resource Exports, this is necessary to replace String references with actual Item references.
func hydrate(values: Array[Dictionary]):
	for value in values:
		if value.item_reference is String:
			value.item_reference = ItemDatabase.get_item(value.item_reference)

@export var sell_value : int
@export var heal_value : int
