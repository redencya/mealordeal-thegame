extends State
class_name GunState

var gun: Gun

func _ready() -> void:
  gun = get_parent().get_parent() as Gun
  assert(gun != null)