@tool
extends GridContainer

# TODO:  Change the exports to ranges on integers

@export var storage : Resource
@onready var saved_size : int = storage.dimensions.x * storage.dimensions.y
const INVENTORY_SLOT_DISPLAY = preload("res://items/item_display.tscn")


func delete_children(node):
	for n in node.get_children():
			node.remove_child(n)
			n.queue_free()

# If the amount changes, clear the children and re-render.
func render_table(table_size: int) -> void:
	if get_child_count() > 0:
		delete_children(self)
	for i in range(table_size):
		var slot = INVENTORY_SLOT_DISPLAY.instantiate()
		add_child(slot)
		slot.set_owner(get_tree().edited_scene_root)
		# Render a button on base Grid
	# If the size changes, re-render the grid
# All of this should be previewable from the editor (thanks to @tool)

func run() -> void:
	set_columns(storage.dimensions.x)
	render_table(storage.dimensions.x * storage.dimensions.y)

func _ready():
	if not Engine.is_editor_hint():
		run()

func _process(_delta : float):
	if Engine.is_editor_hint():
		if saved_size != storage.dimensions.x * storage.dimensions.y:
			run()
			saved_size = storage.dimensions.x * storage.dimensions.y