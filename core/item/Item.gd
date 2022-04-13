extends Resource
class_name Item

@export var name : String
@export var stack_amount : int
@export var texture : AtlasTexture = preload("res://items/item_atlas.tres")
@export_multiline var description