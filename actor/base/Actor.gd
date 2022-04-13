extends CharacterBody2D
class_name Actor
# Don't bother making exports, because they won't come up in children
@export var health : Resource
@export var storage : Resource

func _ready():
  print(str(self.name) + "is ready!")

var direction: Vector2 = Vector2.DOWN

func _destroy():
  queue_free()
# Void method for destruction
# Support polymorphism on children via a simple health check