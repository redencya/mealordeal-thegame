extends Node2D
class_name Gun, "res://svg/gun.svg"

enum GunState {
	RELOAD, USEABLE, EMPTY
}
@onready var reload_timer : Timer = $Reload
@onready var muzzle : Position2D  = $Muzzle
const Bullet : PackedScene = preload("res://bullet.tscn/")
var ammo_max : int = 10
var ammo_current : int = ammo_max
var current_gun_state : GunState = GunState.USEABLE


func deplete_ammo():
	ammo_current -= 1
	if ammo_current == 0: 
		current_gun_state = GunState.EMPTY

func reload(delta : float):
	current_gun_state = GunState.RELOAD
	reload_timer.start(ammo_max * delta)

func _on_reload_timeout():
	ammo_current = ammo_max
	current_gun_state = GunState.USEABLE


func track_subject_direction(subject: Vector2):
	var subject_position : Vector2 = subject
	var muzzle_position : Vector2 = muzzle.global_position
	var direction : Vector2 = muzzle_position.direction_to(subject_position)
	return direction

func spawn_bullet_relative_to(subject: Vector2):
	if current_gun_state != GunState.USEABLE: 
		return

	var bullet : Bullet  = Bullet.instantiate()
	var bullet_direction : Vector2 = track_subject_direction(subject)
	var bullet_parent : Node = get_node("/root/")

	bullet.set_course_to(bullet_direction)
	bullet.global_position = muzzle.global_position
	bullet_parent.add_child(bullet)
	deplete_ammo()


func _process(delta):
	print(current_gun_state)
	if current_gun_state == GunState.EMPTY:
		reload(delta)
