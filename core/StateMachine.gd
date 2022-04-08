class_name StateMachine extends Node

@export_node_path(Node) var base_path
@export_node_path(Node) var current_state_path
@export_node_path(Node) var states_path
@onready var _base = get_node(base_path)
@onready var _current_state = get_node(current_state_path)
@onready var _states = get_node(states_path).get_children()

func change_state(state_name: String):
	var new_state = get_state_from_states(_states, state_name)
	_current_state = _current_state if (new_state == null) else new_state

func get_state_from_states(states: Array[Node], string_name : String):
	for state in states:
		if (state.name == StringName(string_name)):
			return state
	return null

func _physics_process(_delta):
	if (_current_state != null):
		_current_state.physics(self, _base)

func _process(_delta):
	#_current_state.run(self)
	pass
