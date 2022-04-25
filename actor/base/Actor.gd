extends CharacterBody2D
class_name Actor

@export var health : Resource
@export var storage : Resource
@export var speed_base : float

var direction: Vector2 = Vector2.DOWN

func _ready():
	health.current = health.base
	health.connect("health_changed", _on_health_changed)
	health.connect("health_empty", _on_health_empty)

# This behavior can be redefined across children to allow for an easy polymorphic solution for Actor death.
func _on_health_empty():
	queue_free()

func _on_health_changed(_new_health : int):
	pass
