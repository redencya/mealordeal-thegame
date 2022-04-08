extends State

func enter(_machine : StateMachine):
	# Play the running animation with the matching run direction
	pass

func physics(machine : StateMachine, _base):
	if (Input.is_action_just_released("run")):
		machine.change_state("Walk")
	# WHILE the run key is pressed and Stamina isn't depleted, stay in this state
		# Work similarily to the WALK state, with slower deceleration in place and higher base speed
	# IF the run key is released or Stamina is depleted, transition to WALK state
	# If the dodge key is pressed and there's enough stamina for a dodge, transition to DODGE state

func run(_machine : StateMachine):
	# Passively deplete Stamina values
	pass

func exit(_base):
		pass
