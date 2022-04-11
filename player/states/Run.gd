extends PlayerState

@export var walk : String

func physics_update(_delta: float) -> void:
	player.direction = (player.direction 
	if Input.get_vector("go_left", "go_right", "go_up", "go_down") == Vector2.ZERO
	else Input.get_vector("go_left", "go_right", "go_up", "go_down"))
	player.controller.move()

	if (Input.is_action_just_released("run") 
		|| Input.get_vector("go_left", "go_right", "go_up", "go_down") == Vector2.ZERO):
		state_machine.change_state(walk)

func exit() -> void:
	player.controller.toggle_run()

func enter(_msg := {}) -> void:
	player.controller.toggle_run()
