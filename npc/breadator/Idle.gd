extends EnemyState

# Used for randomizing a point for the enemy to go to
const UNIT_VECTOR = Vector2.UP
const RADIUS_LIMIT : float = 40.0
const ANGLE_LIMIT : float = 180.0

var destination : Vector2:
	set(point): destination = breadator.global_position + point

# This function is used to create a random destination relative to the enemy position.
func randomize_destination() -> void:
	var _random_angle = randf_range(-ANGLE_LIMIT, ANGLE_LIMIT)
	var _random_radius = randf_range(0, RADIUS_LIMIT)
	destination = UNIT_VECTOR.rotated(_random_angle) * _random_radius

func enter(_msg := {}):
	randomize_destination()
