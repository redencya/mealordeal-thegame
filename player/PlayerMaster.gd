extends Actor
class_name Player
# This is used to determine speed of the character
@export var speed_max : float
@export_range(0, 1, 0.001) var acceleration_rate : float
@export_range(0, 1, 0.001) var deceleration_rate : float

# this is based on percentile acc/dec rates
@onready var acceleration := acceleration_rate * speed_max
@onready var deceleration := deceleration_rate * speed_max

var speed_current : float
var current_direction : Vector2

func calculate_movement() -> Vector2:
	if (Input.get_vector("go_left", "go_right", "go_up", "go_down") != Vector2.ZERO):
		current_direction = Input.get_vector("go_left", "go_right", "go_up", "go_down")
		speed_current = min(speed_current + acceleration, speed_max)
	else:
		speed_current = max(speed_current - deceleration, 0)

	return current_direction * speed_current

func _physics_process(_delta):
	print(velocity)
	speed_calculate()
	velocity = calculate_movement()
	move_and_slide()

func speed_calculate():
	if Input.is_action_pressed("run") && !$Stamina.depleted:
		#stamina.run()
		speed_max = 500
	else:
		speed_max = 250
	