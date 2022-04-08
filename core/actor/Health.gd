extends Node
class_name Health, "res://svg/health.svg"

var max_value : int
@onready var current_value = max_value

var invulnerable := false
var healable := false


func _on_hitbox_body_entered(body:Node2D):
	if body is Bullet:
		current_value -= body.damage
