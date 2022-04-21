extends Position2D
class_name Gun

const BULLET = preload("res://shooter/bullet.tscn")
var player: Player

var can_shoot : bool = true

func _ready() -> void:
	player = owner as Player
	assert(player != null)

func fire(target: Vector2) -> void:
	$Shot.play()
	$Timer.start()
	can_shoot = false
	var bullet : Bullet = BULLET.instantiate()
	get_tree().get_root().add_child(bullet)
	bullet.direction = target
	bullet.parent = player
	bullet.global_position = global_position

func _input(event):
	if event.is_action_pressed("shoot") and can_shoot:
		fire(global_position.direction_to(get_global_mouse_position()))

func _on_timer_timeout():
	can_shoot = true
