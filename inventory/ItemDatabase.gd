extends Node
class_name ItemDB

var items : Array[Item]

func _ready():
	var directory = Directory.new()
	directory.open("res://items/")
	directory.list_dir_begin()

	var filename = directory.get_next()
	while(filename):
		if !directory.current_is_dir():
			items.append(load("res://items/%s" % filename))

		filename = directory.get_next()


func get_item(item_name : String) -> Item:
	for item in items:
		if item.name == item_name:
			return item

	return null
