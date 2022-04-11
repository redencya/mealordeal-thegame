extends Resource
class_name Stamina

signal burnout

@export var base : float
@onready var current := base
var active = false

@export_range(0, 1, 0.001) var drain:
	get: return drain
	set(v): drain = v * base

@export_range(0, 1, 0.001) var gain:
	get: return gain
	set(v): gain = v * base

func run() -> void:
	if active:
		burn()
	else:
		restore()

# This function shouldn't be called from any other script, as no other script should be concerned with how Stamina restores itself.
func restore() -> void:
	if current == base:
		return

	current = min(current + gain, base)

func burn(amount: int = drain) -> void:
	if current - amount < 0:
		active = false
		emit_signal("burnout")
		return

	current = max(current - amount, 0)
