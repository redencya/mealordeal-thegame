extends PlayerState

@export var idle : String
@export var dodge : String
@export var run : String

func physics_update(_delta: float) -> void:
	player.update_direction()
	player.move()

	if (Input.get_vector("go_left", "go_right", "go_up", "go_down") == Vector2.ZERO):
		state_machine.change_state(idle)

	if (Input.is_action_pressed("run") 
		&& Input.get_vector("go_left", "go_right", "go_up", "go_down") != Vector2.ZERO): # && !stamina_depleted()
		state_machine.change_state(run)

	if Input.is_action_just_pressed("dodge"):
		state_machine.change_state(dodge)

func enter(_msg := {}):
	player.animation_state_machine.travel("Walk")	

func update(_delta : float):
	pass
