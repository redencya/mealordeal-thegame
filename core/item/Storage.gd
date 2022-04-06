extends Node
class_name Storage

var content : Array[Item]
var size : Vector2

@onready var content_length_max = size.x * size.y

func insert(item : Item):
  if content.size() >= content_length_max : return
  pass

func eject(item : Item):
  content.erase(item)
  spawn(item)

func spawn(item : Item):
  pass

func transfer(old_storage: Storage, new_storage: Storage, item: Item):
  pass