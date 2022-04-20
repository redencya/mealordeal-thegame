extends EnemyState

const RADIUS_LIMIT : float = 40.0
const ANGLE_LIMIT : float = 180.0

func create_idle_path() -> Vector2:
  var radius = randf_range(0, RADIUS_LIMIT)
  var angle = randf_range(-ANGLE_LIMIT, ANGLE_LIMIT)
  return Vector2.UP

func move_along_idle_path() -> void:
  var current_idle_path : Vector2

  if current_idle_path == null:
    current_idle_path = create_idle_path()
  
  # Vision.targetpos = origin + current idle path
  # NavAgent set target location
  # ya di da di da