extends State

func enter(_machine : StateMachine):
	# Play the walking animation with the matching walk direction
	pass

func physics(machine : StateMachine, base):
		# WHILE the walking vector input keys are pressed, stay in the state
	base.velocity = base.calculate_movement()

	if (Input.get_vector("go_left", "go_right", "go_up", "go_down") == Vector2.ZERO):
		if exit(base):
			machine.change_state("Idle")

	# Walk around using the created Direction and computed Speed stats
	# IF the keys are released, wait a bit and transition to IDLE state
	# IF the run key is pressed and stamina is higher than 0, transition to RUN state
	
	if (Input.is_action_pressed("run")):
		machine.change_state("Run")

	# If the dodge key is pressed and there's enough stamina for a dodge, transition to DODGE state

func run(_machine : StateMachine):
	# Passively replenish Stamina values
	pass

func exit(base):
	if (base.velocity != Vector2.ZERO):
		base.velocity = base.decalculate_movement()
		return false
	return true