extends Area2D
class_name Hazard

signal damage

func hit(target: Hitbox, amount : int) -> void:
  target.value_current -= amount

func _ready():
  pass
