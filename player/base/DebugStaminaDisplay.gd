extends ProgressBar

@export var stamina : Resource

func _ready():
	call_deferred("set_max", stamina.base)

func _process(_delta):
	set_value(stamina.current)
