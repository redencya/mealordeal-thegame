extends Resource
class_name Controller

@export var stamina : Resource
@export var speed : Resource

func compute_velocity(direction: Vector2) -> Vector2:
	return speed.current * direction

func burn_stamina(_amount = stamina.drain):
	speed.running = true
	#stamina.current -= amount

func restore_stamina(_amount = stamina.gain):
	speed.running = false
	#stamina.current = stamina.current + amount

func move():
	speed.current += speed.acceleration

func stop():
	if speed.current == 0: return

	speed.current += speed.deceleration