extends Position2D
class_name Gun

const BULLET = preload("res://shooter/bullet.tscn")
var player: Player

func _ready() -> void:
	player = owner as Player
	assert(player != null)

func fire() -> void:
	var bullet : Bullet = BULLET.instantiate()
	get_tree().get_root().add_child(bullet)
	bullet.global_position = global_position
	bullet.set_course_to(player.direction)