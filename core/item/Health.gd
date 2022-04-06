extends Node
class_name Health

var value_max : int
@onready var value_current := value_max

var passive_heal : bool
var immortal : bool

func restore(amount := value_max) -> void:
  value_current = min(value_current + amount, value_max)