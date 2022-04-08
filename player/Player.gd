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
@onready var state_machine : StateMachine = $PlayerSM

func _ready():
	state_machine._current_state = $States/Idle
	state_machine._states = $States.get_children()
	state_machine._base = self

# This will go into the Walk state
func calculate_movement():
	if (Input.get_vector("go_left", "go_right", "go_up", "go_down") != Vector2.ZERO):
		current_direction = Input.get_vector("go_left", "go_right", "go_up", "go_down")
		speed_current = min(speed_current + acceleration, speed_max)
	else:
		speed_current = max(speed_current - deceleration, 0)

	return current_direction * speed_current

func decalculate_movement():
	speed_current = max(speed_current - deceleration, 0)
	return current_direction * speed_current

func _physics_process(_delta):
	print(velocity)
	speed_calculate()
	move_and_slide()
	$StateName.set_text(state_machine._current_state.name)

func speed_calculate():
	if Input.is_action_pressed("run"):
		#stamina.run()
		speed_max = 500
	else:
		speed_max = 250
