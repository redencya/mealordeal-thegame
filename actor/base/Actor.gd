extends CharacterBody2D
class_name Actor
# Don't bother making exports, because they won't come up in children
@export var health : Resource
@export var storage : Resource

var direction: Vector2 = Vector2.DOWN

# Void method for destruction
# Support polymorphism on children via a simple health check
