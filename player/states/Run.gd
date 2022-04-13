extends PlayerState

@export var walk : String
@export var dodge : String

func physics_update(_delta: float) -> void:
	player.direction = (player.direction 
	if Input.get_vector("go_left", "go_right", "go_up", "go_down") == Vector2.ZERO
	else Input.get_vector("go_left", "go_right", "go_up", "go_down"))
	player.controller.move()

	if (Input.is_action_just_released("run") 
		|| Input.get_vector("go_left", "go_right", "go_up", "go_down") == Vector2.ZERO):
		state_machine.change_state(walk)

	if Input.is_action_just_pressed("dodge"):
		state_machine.change_state(dodge)

func enter(_msg := {}):
	player.sprite.animation = "Run"

func update(_delta : float):
	player.controller.burn_stamina()
