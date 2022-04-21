extends State
class_name EnemyState

var breadator : Enemy

func _ready() -> void:
  breadator = owner as Enemy
  assert(breadator != null)
