extends PlayerState

const DODGE_COST : float = 50.0
@export var idle : String

func physics_update(_delta : float):
	player.move()

func enter(_msg := {}):
	player.sprite.animation = "Run"
	$Timer.start(0.5)

func _on_timer_timeout():
	state_machine.change_state(idle)