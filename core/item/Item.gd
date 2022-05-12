extends Resource
class_name Item

# Display
@export var name : String
@export var texture : Texture

# Stack logic
@export var max_stack_size : int
@export var stackable : bool