extends PlayerState

@export var walk : String
@export var dodge : String

func physics_update(_delta: float) -> void:
	player.update_direction()
	player.move()

	if (Input.is_action_just_released("run") 
		|| Input.get_vector("go_left", "go_right", "go_up", "go_down") == Vector2.ZERO):
		state_machine.change_state(walk)

	if Input.is_action_just_pressed("dodge"):
		state_machine.change_state(dodge)

func enter(_msg := {}):
	player.running = true
	player.animation_state_machine.travel("Run")

func exit():
	player.running = false

func update(_delta : float):
	pass
