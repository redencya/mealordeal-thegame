extends Resource
class_name Controller

var final_speed : float

@export var stamina : Resource = Stamina.new()
@export var speed : Resource = Speed.new()

func computed_limit() -> float:
	if stamina.active:
		return speed.base + speed.run_modifier
	return speed.base

func move():
	#if stamina.active:
	#	stamina.burn()
	#stamina.restore()
	speed.current = min(speed.current + speed.acceleration, computed_limit())

func stop():
	#stamina.restore()
	speed.current = max(speed.current - speed.deceleration, 0)
