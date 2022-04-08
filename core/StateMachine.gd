extends Node
class_name StateMachine

var states : Array[State]
var current_state : State

func add_state(_machine: StateMachine, _state: State):
  pass

func change_state(_machine: StateMachine, _old_state: State, _new_state: State):
  pass

func _physics_process(delta):
  current_state.run_physics(delta)

func _process(_delta):
  current_state.run()