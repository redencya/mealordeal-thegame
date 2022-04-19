extends CharacterBody2D
class_name Bullet, "res://svg/bullet.svg"

signal send_damage

const LINEAR_SPEED : float = 275.0
const LIFESPAN : float = 1.666
var   age_left : float = LIFESPAN
var   direction : Vector2 = Vector2.ZERO

func on_any_collision():
	if move_and_slide():
		die()

func calc_age(delta: float):
	if age_left <= 0: die()
	age_left -= delta 

func die():
	velocity = Vector2.ZERO
	queue_free()

func _physics_process(delta: float):
	move_and_slide()
	calc_age(delta)
	velocity = direction * LINEAR_SPEED
