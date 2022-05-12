extends PlayerState

@export var walk : String
@export var dodge : String

func physics_update(_delta: float) -> void:

	player.stop()

	if Input.is_action_just_pressed("dodge"):
		state_machine.change_state(dodge)

	if (Input.get_vector("go_left", "go_right", "go_up", "go_down") != Vector2.ZERO):
		state_machine.change_state(walk)

func enter(_msg := {}):
	player.animation_state_machine.travel("Idle")
