extends Actor
class_name Enemy

# Health preference
# 5 HP : 1 person
const PHYSICS_LAYER_PLAYER_DETECTION = 32768

const ITEM_DROP : PackedScene = preload("res://actor/base/entity.tscn")
const SOUND_DIE : AudioStreamSample = preload("res://npc/enemy_death.wav")
const SOUND_HURT : AudioStreamSample = preload("res://npc/enemy_hurt.wav")
# A cone of vision expressed in degrees. This is used for generating raycasts.
const CONE_OF_VISION : float = deg2rad(90.0)
const ANGLE_BETWEEN_RAYS : float = deg2rad(4.0)
const VIEW_DISTANCE : float = 250.0
var target : Player = null
@onready var ray_collection = $RayCollection

func _ready():
	print("PREPARING %s" % str(name).to_upper())

	health.current = health.base
	generate_raycasts()
	prepare_debug_interfaces()
	super._ready()

	print("\n")

func set_params() -> void:
	print("Setting entity parameters...")
	health.current = health.base
	print("Entity parameters set!")

func prepare_debug_interfaces():
	print("Preparing debug interfaces...")
	$Label.text = str(health.base)
	$ProgressBar.max_value = health.base
	$ProgressBar.value = health.current
	print("Debug interfaces prepared!")

func generate_raycasts():
	print("Generating raycasts...")
	var ray_count : int = CONE_OF_VISION / ANGLE_BETWEEN_RAYS
	for index in ray_count:
		var ray : RayCast2D = RayCast2D.new()
		var angle : float = ANGLE_BETWEEN_RAYS * (index - ray_count / 2.0)
		ray.target_position = Vector2.UP.rotated(angle) * VIEW_DISTANCE
		ray.collision_mask = PHYSICS_LAYER_PLAYER_DETECTION
		ray_collection.add_child(ray)
		ray.enabled = true
	print("Raycasts generated!")

func update_viewing_angle() -> void:
	var direction = velocity.normalized()
	for ray in ray_collection.get_children():
		var current_index = ray.get_index()
		var ray_count : int = CONE_OF_VISION / ANGLE_BETWEEN_RAYS
		var angle = ANGLE_BETWEEN_RAYS * (current_index - ray_count / 2.0)
		ray.target_position = direction.rotated(angle) * VIEW_DISTANCE

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

func detect() -> bool:
	for ray in ray_collection.get_children():
		ray = ray as RayCast2D
		if ray.get_collider() is Player:
			target = ray.get_collider()
			return true

	if target != null : target == null
	return false

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

func spawn_loot():
	var item = ITEM_DROP.instantiate()
	item.player = target
	item.global_position = global_position
	get_tree().get_root().add_child(item)

# Processing

func _physics_process(_delta):
	update_viewing_angle() 
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

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func _on_hitbox_body_entered(body:Node2D):
	if body is Bullet:
		target = body.parent
		$BaseSM.change_state("Chase") 
		health.current -= 1
		body.queue_free()
		
	if body is Player:
		body.health.current -= 1
