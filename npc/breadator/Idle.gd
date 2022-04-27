extends EnemyState

#@export_node_path(Node) var alert_path
#@onready var alert = get_node(alert_path).name

# Used for randomizing a point for the enemy to go to
const UNIT_VECTOR = Vector2.UP
const RADIUS_LIMIT : float = 80.0
const ANGLE_LIMIT : float = 180.0

var destination : Vector2:
	set(point): destination = breadator.global_position + point

# This function is used to create a random destination relative to the enemy position.
func randomize_destination() -> void:
	var _random_angle = randf_range(-ANGLE_LIMIT, ANGLE_LIMIT)
	var _random_radius = randf_range(RADIUS_LIMIT/4, RADIUS_LIMIT)
	destination = UNIT_VECTOR.rotated(_random_angle) * _random_radius

func physics_update(_delta: float) -> void:
	# if this fails and returns false, randomize a new destination
	# this works because the return works like an exit code and tells the game "hey, this doesn't compile, try again"
	if !breadator.navigate_to(destination):
		randomize_destination()

	if breadator.detect():
		state_machine.change_state("Chase")

func enter(_msg := {}):
	randomize_destination()

func _on_nav_agent_target_reached():
	randomize_destination()
