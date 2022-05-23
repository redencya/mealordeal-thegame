# The item resources exists to serve as an easier way of containing item data.
# This is not quantifiable, and doesn't represent ACTUAL items on the player inventory. It's more of an abstraction for diverse Item types.
# It also prevents refering to items with magic strings, which provides a bit more stability to the code.

extends Resource
class_name Item

# Display
@export var name : String
@export var texture : Texture

# Stack logic
@export var max_stack_size : int
@export var stackable : bool
