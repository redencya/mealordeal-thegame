extends Node
class_name Stamina

var value_max : float
@onready var value_current := value_max

var drain : float
var gain : float
var depleted : bool

func _init(player : Player):
  value_max = player.stamina_max
  drain = player.stamina_drain_rate
  gain = player.stamina_gain_rate

func run() -> void:
  pass