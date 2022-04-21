class_name StateMachine extends Node

signal transitioned_to(state_name: StringName)

@export_node_path(Node) var default_state_path
@onready var current_state = get_node(default_state_path)

func _ready() -> void:
	await owner.ready
	for child in get_children():
		child.state_machine = self
	current_state.enter()

func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta : float) -> void:
	current_state.physics_update(delta)

func change_state(target_state: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state):
		return

	current_state.exit()
	current_state = get_node(target_state)
	current_state.enter(msg)
	emit_signal("transitioned_to", current_state.name)
