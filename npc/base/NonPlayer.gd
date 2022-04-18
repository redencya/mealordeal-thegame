extends Actor
class_name Enemy

var target : Player = null
var point : Vector2
const VISION_MARGIN := Vector2(0, -20)


func _ready():
	super._ready()
	point = draw_trajectory_vector()

# AI Programming
# Technically, this is Breadator behavior, but it shouldn't matter because this will end up in state logic regardless

# TODO:  Idle state (Wandering)
			# draw trajectory vector
			# if not valid, try again
		# travel to the point
		# when destination is reached, repeat

		# if Enemy sees player:
			# state_machine.change_state("Alert")

# TODO:  Alert state (Choosing attack)
		# func enter():
		# 	play_animation("angry_animation")

		# if the Enemy still sees player:
			# choose between Chase, Pounce and Charge
		# else:
			# state_machine.change_state("Idle")

# TODO:  Chase state [halfway]
	# continuously track the player

# TODO:  Charge state

# TODO:  Pounce state


# TODO:  Should be moved into a Chase State later on
# TODO:  Optimize the behavior using polymorphism with Actor

func draw_trajectory_vector() -> Vector2:
	const RADIUS := 50.0
	const STRAIGHT_ANGLE := 180.0
	var determined_angle : float = deg2rad(randf_range(-STRAIGHT_ANGLE, STRAIGHT_ANGLE))
	var determined_radius : float = randf_range(RADIUS/3, RADIUS)

	return Vector2.RIGHT.rotated(determined_angle) * determined_radius

func chase():
	if $Vision.get_collider() is Player:
		target = $Vision.get_collider()
		$Vision.target_position = (target.global_transform.origin - global_transform.origin) + VISION_MARGIN

	if target:
		$NavAgent.set_target_location(target.global_transform.origin)
		var next_path_position : Vector2 = $NavAgent.get_next_location()
		var current_agent_position : Vector2 = global_transform.origin
		var new_velocity : Vector2 = (next_path_position - current_agent_position).normalized() * speed_base
		$NavAgent.set_velocity(new_velocity)

# Processing

func _physics_process(_delta):
	chase()

# Signals

func _on_health_empty():
	queue_free()

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()