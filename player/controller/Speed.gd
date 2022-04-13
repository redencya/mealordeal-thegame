extends Resource
class_name Speed

@export var base : float
@export_range(0, 2, 0.01) var run_modifier : float:
	set(v): run_modifier = v * base
@onready var base_adjusted : float:
	get: 
		if running:
			return base + run_modifier
		else:
			return base
var running : bool = false

@export_range(0, 1, 0.001) var acceleration : float:
	set(v): acceleration = v * base_adjusted
@export_range(0, 1, 0.001) var deceleration : float:
	set(v): deceleration = -v * base_adjusted

var current : float = 0.0:
	set(v):
		current = clamp(v, 0, base_adjusted)