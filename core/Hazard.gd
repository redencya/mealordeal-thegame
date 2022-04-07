extends Area2D
class_name Hazard

signal damage

func hit(target: Health, amount : int) -> void:
  target.value_current -= amount

func _ready():
  