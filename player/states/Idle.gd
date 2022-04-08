extends State

func enter(_machine: StateMachine):
  # Play idle animation for the player
  # Consider player's direction in this
  pass

func physics(machine: StateMachine, _base):
  if (Input.get_vector("go_left", "go_right", "go_up", "go_down") != Vector2.ZERO):
    machine.change_state("Walk")
  # WHILE no input is given, stay idle
  # IF input is given and it matches the walking vector, transition to WALK state
  # If the dodge key is pressed and there's enough stamina for a dodge, transition to DODGE state
  # IF character recieves flinch signal, transition to FLINCH state (low priority)

func run(_machine: StateMachine):
  # Passively replenish Stamina values
  pass

func exit(_base):
    pass