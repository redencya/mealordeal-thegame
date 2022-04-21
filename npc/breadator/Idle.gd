extends EnemyState

const RADIUS_LIMIT : float = 40.0
const ANGLE_LIMIT : float = 180.0

#func assign_idle_path() -> void:
#	var radius = randf_range(0, RADIUS_LIMIT)
#	var angle = randf_range(-ANGLE_LIMIT, ANGLE_LIMIT)
#	var generated_idle_path = Vector2.UP.rotated(angle) * radius
#	breadator.nav_agent.set_target_location(
#		breadator.global_transform.origin + generated_idle_path)

#func move_along_idle_path() -> void:
#	if breadator.nav_agent.is_target_reachable():
#		var next_path_position : Vector2 = breadator.nav_agent.get_next_location()
#		var current_agent_position := breadator.global_transform.origin
#		var new_velocity := (next_path_position - current_agent_position).normalized() * breadator.speed_base
#		breadator.nav_agent.set_velocity(new_velocity)
#	else:
#		breadator.nav_agent.set_target_location(breadator.global_transform.origin)
#
#func enter(_msg := {}):
#	assign_idle_path()
	
#func physics_update(_delta: float) -> void:
#	#move_along_idle_path()
#	pass
#
#func _on_nav_agent_target_reached():
#	assign_idle_path()
