extends Resource
class_name Speed

signal speed_changed(new_speed: float)

@export var base : float
@export var run_modifier : float

@export_range(0, 1, 0.001) var acceleration : float:
	get: return acceleration
	set(v): acceleration = v * base

@export_range(0, 1, 0.001) var deceleration : float:
	get: return deceleration
	set(v): deceleration = v * base

@export_range(0, 1, 0.001) var run_acceleration : float:
		get: return run_acceleration
		set(v): run_acceleration = v * base

@export_range(0, 1, 0.001) var run_deceleration : float:
		get: return run_deceleration
		set(v): run_deceleration = v * base

var current : float = 0.0


func move(step: float, limit: float) -> void:
	if current == limit:
		return
	current = min(current + step, limit)
	emit_signal("speed_changed", current)

func stop(step: float, limit: float) -> void:
	if current == limit:
		return
	current = max(current - step, limit)
	emit_signal("speed_changed", current)
	


