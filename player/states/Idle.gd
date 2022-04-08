extends PlayerState

@export var walk : String
@export var dodge : String

func physics_update(_delta: float) -> void:
	player.stop()

	if (Input.get_vector("go_left", "go_right", "go_up", "go_down") != Vector2.ZERO):
		state_machine.change_state(walk)
