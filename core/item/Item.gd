extends Resource
class_name Item

enum ItemType {
	Ingredient,
	Sandwich,
	Quest,
	Junk
}

# Display
@export var name : String
@export var texture : Texture

# Data
@export var type : ItemType
@export var sell_value : int

# Stack logic
@export var max_stack_size : int
@export var stackable : bool

