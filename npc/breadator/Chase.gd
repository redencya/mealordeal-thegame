extends EnemyState

func physics_update(_delta: float) -> void:
	breadator.navigate_to(breadator.target.global_position)
	if !breadator.detect():
		state_machine.call_deferred("change_state", "Idle")
