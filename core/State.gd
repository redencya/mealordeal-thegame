class_name State extends Node

var state_machine: StateMachine = null

func handle_input(_event) -> void:
	pass

func update(_delta: float) -> void:
	pass

# Extension of native [_physics_process] method for State use.
func physics_update(_delta: float) -> void:
	pass

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass
