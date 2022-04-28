extends PlayerState

# Right now, because there's no dodging animation, this state operates on a timer.
# However, when a proper dodge animation is added, we'll just await its finish and exit.

const DODGE_COST : float = 50.0
@export var idle : String

func physics_update(_delta : float):
	player.move()

func enter(_msg := {}):
	$Timer.start(0.5)

func _on_timer_timeout():
	state_machine.change_state(idle)
