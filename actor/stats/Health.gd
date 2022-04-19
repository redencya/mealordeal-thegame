extends Resource
class_name Health

# When this signal is called to the Actor, the actor is DESTROYED
signal health_empty
signal health_changed(new_health)

@export var base : int
var current : int = base:
	get: return current
	set(v): 
		var previous = current
		current = clamp(v, 0, base)
		print(current)
		if current != previous:
			emit_signal("health_changed", current)
			if current == 0 && !invulnerable:
				emit_signal("health_empty")

@export var invulnerable : bool = false
