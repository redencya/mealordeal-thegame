extends State

func enter(_machine : StateMachine):
  pass

func physics(_machine : StateMachine, _base):
  # Execute a dodge
    # Enable IFrames
    # Compute dodge length based on entry state -> IDLE, WALK, RUN?
    # When the dodge is finished, transition out of it into IDLE
  pass

func run(_machine : StateMachine):
  # Subtract a chunk of stamina
  pass

func exit(_base):
  pass