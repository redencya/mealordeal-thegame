extends Actor
class_name NonPlayer

var target : Player = null
var speed := 150.0
const VISION_MARGIN := Vector2(0, -20)

func chase():
	if $Vision.get_collider() is Player:
		target = $Vision.get_collider()
		$Vision.target_position = (target.global_transform.origin - global_transform.origin) + VISION_MARGIN

	if target:
		$NavAgent.set_target_location(target.global_transform.origin)
		var next_path_position : Vector2 = $NavAgent.get_next_location()
		var current_agent_position : Vector2 = global_transform.origin
		var new_velocity : Vector2 = (next_path_position - current_agent_position).normalized() * speed
		$NavAgent.set_velocity(new_velocity)

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func _physics_process(_delta):
	chase()

