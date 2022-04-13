extends PlayerState

@export var walk : String
@export var dodge : String

func physics_update(_delta: float) -> void:
	player.controller.stop()

	if Input.is_action_just_pressed("dodge"):
		state_machine.change_state(dodge)

	if (Input.get_vector("go_left", "go_right", "go_up", "go_down") != Vector2.ZERO):
		state_machine.change_state(walk)

func enter(_msg := {}):
	player.sprite.animation = "Idle"

func update(_delta : float):
	player.controller.restore_stamina()