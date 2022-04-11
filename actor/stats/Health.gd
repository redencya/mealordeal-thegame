extends Resource
class_name Health

signal health_empty
signal health_changed(amount)

@export var base : int
@onready var current := base
@export var invulnerable : bool = false

func heal(amount: int = base) -> void:
  current = min(current + amount, base)
  emit_signal("health_changed", amount)

func take_damage(amount: int) -> void:
  if invulnerable: return

  if current - amount <= 0:
    emit_signal("health_empty")
    return

  current -= amount
  emit_signal("health_changed", amount)