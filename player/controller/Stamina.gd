extends Resource
class_name Stamina

signal burnout

@export var base : float
@onready var current := base:
	set(v):
		current = clamp(v, 0, base)
		if current == 0:
			emit_signal("burnout") 

@export_range(0, 1, 0.01) var drain:
	set(v): drain = v * base
@export_range(0, 1, 0.01) var gain:
	set(v): gain = v * base

func deplete(delta: float):
	current -= drain * delta

func replenish(delta: float):
	current += gain * delta