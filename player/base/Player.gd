extends Actor
class_name Player

@export var inventory : Resource
@export var stamina : Resource
@onready var animation_state_machine = $AnimationTree.get("parameters/playback")

@export_range(0, 2, 0.01) var run_modifier : float:
	set(v): run_modifier = v * speed_base
@export_range(0, 1, 0.001) var acceleration : float:
	set(v): acceleration = v * speed_base
@export_range(0, 1, 0.001) var deceleration : float:
	set(v): deceleration = -v * speed_base 

var speed_current : float = 0.0:
	set(v):
		speed_current = clamp(v, 0, speed_base)

# The Ready method on the player should just have some signal connections and debug stuff.
# There's no real reason to use any more often.
func _ready():
	stamina.current = stamina.base
	super._ready()
	$ProgressBar.max_value = $Gun/Timer.wait_time

# This function exists to simplify the process of setting the direction on the base of the AnimationTree blend space.
# Normally this would have to be handled manually, but by calling for the name of the node, it's possible to automate the process.
func set_current_blend_space() -> void:
	var current_node_name = str(animation_state_machine.get_current_node())
	$AnimationTree.set("parameters/" + current_node_name + "/blend_position", direction)


# Movement calculations

func compute_velocity(dir: Vector2) -> Vector2:
	return speed_current * dir

func update_direction() -> void:
	direction = (direction 
	if Input.get_vector("go_left", "go_right", "go_up", "go_down") == Vector2.ZERO
	else Input.get_vector("go_left", "go_right", "go_up", "go_down"))

func move() -> void:
	speed_current += acceleration

func stop() -> void:
	if speed_current == 0: return
	speed_current += deceleration


# Processing

func _process(_delta: float) -> void:
	$ProgressBar.value = $Gun/Timer.time_left
	set_current_blend_space()

	# I have absolutely no idea why this operation needs that random 
	# 90 degree angle, but it's the only thing that works.
	$Interact/Collider.rotation = direction.angle() - deg2rad(90)

func _physics_process(_delta: float) -> void:
	velocity = compute_velocity(direction)
	move_and_slide()


# Signals

func _on_health_changed(_new_health: int):
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(
		$Sprite, "modulate", Color("ff0000"), 0.25).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(
		$Sprite, "modulate", Color("ffffff"), 0.05).set_trans(Tween.TRANS_LINEAR)

func _on_health_empty():
	# Lock the physics
	# Play a blackout animation
	# Skip ahead to the next day
	# Charge the player with a fee
	process_mode = Node.PROCESS_MODE_DISABLED

# THIS IS A DEBUG FEATURE!!!!!!!! IT WILL BE DELETED LATER ON
func _on_base_sm_transitioned_to(state_name: StringName):
	$StateName.set_text(str(state_name))
