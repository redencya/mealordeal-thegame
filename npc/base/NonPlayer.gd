extends Actor
class_name Enemy

# Health preference
# 5 HP : 1 person
const ITEM_DROP = preload("res://actor/base/entity.tscn")
const SOUND_DIE = preload("res://npc/enemy_death.wav")
const SOUND_HURT = preload("res://npc/enemy_hurt.wav")

var target : Player = null

func _ready():
	print("PREPARING %s" % str(name).to_upper())

	health.current = health.base
	generate_raycasts()
	prepare_debug_interfaces()
	super._ready()

	print("\n")

func prepare_debug_interfaces():
	print("Preparing debug interfaces...")

	$Label.text = str(health.base)
	$ProgressBar.max_value = health.base
	$ProgressBar.value = health.current

	print("Debug interfaces prepared!")

func generate_raycasts():
	print("Generating raycasts...")

	print("Raycasts generated!")

# this function will return a TRUE value if navigation succeeded
# and a FALSE value if the given location is impossible to reach
func navigate_to(navigation_target: Vector2) -> bool:
	var nav_agent : NavigationAgent2D = $NavAgent

	# set a target, write changing code for fixing unreachable targets
	nav_agent.set_target_location(navigation_target)
	if !nav_agent.is_target_reachable(): return false

	# this is here to make velocity calculations easier to read
	var next_position : Vector2 = nav_agent.get_next_location()
	var current_position : Vector2 = global_transform.origin

	# make the enemies move in the new direction
	var new_velocity : Vector2 = (next_position - current_position).normalized() * speed_base
	nav_agent.set_velocity(new_velocity)

	return true


# AI Programming
#TODO:  Should be moved into a Chase State later on
#TODO:  Optimize the behavior using polymorphism with Actor

# func draw_trajectory_vector() -> Vector2:
# 	const RADIUS := 25.0
# 	const STRAIGHT_ANGLE := 180.0
# 	var determined_angle : float = deg2rad(randf_range(-STRAIGHT_ANGLE, STRAIGHT_ANGLE))
# 	var determined_radius : float = randf_range(RADIUS/3, RADIUS)
	
# 	return Vector2.DOWN.rotated(determined_angle) * determined_radius

# func chase():
# 	if $Vision.get_collider() is Player:
# 		target = $Vision.get_collider()
	
# 	if target:
# 		$Vision.target_position = (target.global_position - global_position).limit_length(200.0)
# 		$NavAgent.set_target_location(target.global_transform.origin)
# 		var next_path_position : Vector2 = $NavAgent.get_next_location()
# 		var current_agent_position : Vector2 = global_transform.origin
# 		var new_velocity : Vector2 = (next_path_position - current_agent_position).normalized() * speed_base
# 		$NavAgent.set_velocity(new_velocity)

# 	else:
# 		idle()

# func idle():
# 	$Vision.target_position = point.normalized() * 140

# 	$NavAgent.set_target_location(global_transform.origin + point)
# 	if !$NavAgent.is_target_reachable():
# 		point = draw_trajectory_vector()
# 	var next_path_position : Vector2 = $NavAgent.get_next_location()
# 	var current_agent_position : Vector2 = global_transform.origin
# 	var new_velocity : Vector2 = (next_path_position - current_agent_position).normalized() * speed_base
# 	$NavAgent.set_velocity(new_velocity)

# Debug function, to be replaced with actual damage reaction later on.
func debug_hurt(new_health: int):
	var tween : Tween = get_tree().create_tween().bind_node(self)

	const COLOR_REGULAR = Color("ffffff")
	const COLOR_HURT = Color("ffabab")

	tween.tween_property($ProgressBar, "value", float(new_health), 0.25).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Sprite, "modulate", COLOR_HURT, 0.15).set_trans(Tween.TRANS_EXPO)
	tween.parallel().tween_property($Sprite, "scale", Vector2(1.1, 1.1), 0.1).set_trans(Tween.TRANS_LINEAR)
	tween.parallel().tween_property($Sprite, "rotation", deg2rad(float(randi_range(-10, 10))), 0.1).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($Sprite, "modulate", COLOR_REGULAR, 0.25).set_trans(Tween.TRANS_EXPO)
	tween.parallel().tween_property($Sprite, "scale", Vector2(1, 1), 0.1).set_trans(Tween.TRANS_LINEAR)
	tween.parallel().tween_property($Sprite, "rotation", deg2rad(0), 0.1).set_trans(Tween.TRANS_LINEAR)

# Processing

func _physics_process(_delta):
	# chase()
	$Sprite.flip_h = velocity.x > 0

# Signals

func _on_health_changed(new_health : int):
	$Hurt.play()
	$Label.text = str(new_health)
	debug_hurt(new_health)

func _on_health_empty():
	var tween : Tween = get_tree().create_tween().bind_node(self)

	const COLOR_HURT = Color("ffabab")
	tween.tween_property($Sprite, "rotation", deg2rad(100), 0.45).set_trans(Tween.TRANS_LINEAR)
	tween.parallel().tween_property($Sprite, "modulate", COLOR_HURT, 0.2).set_trans(Tween.TRANS_EXPO)
	$Death.play()
	
	await tween.finished && $Death.finished
	spawn_loot()
	queue_free()

func spawn_loot():
	var item = ITEM_DROP.instantiate()
	item.player = target
	item.global_position = global_position
	get_tree().get_root().add_child(item)

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func _on_hitbox_body_entered(body:Node2D):
	if body is Bullet:
		target = body.parent 
		health.current -= 1
		body.queue_free()
		
	if body is Player:
		body.health.current -= 1

# func _on_nav_agent_target_reached():
# 	if !target:
# 		point = draw_trajectory_vector()
