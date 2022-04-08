extends Actor
class_name Player

@export var speed_max: float
@export_range(0, 1, 0.001) var acceleration_rate : float
@export_range(0, 1, 0.001) var deceleration_rate : float

var speed: float = 0.0
var direction: Vector2 = Vector2.DOWN
@onready var acceleration := acceleration_rate * speed_max
@onready var deceleration := deceleration_rate * speed_max

func _process(_delta: float) -> void:
	$StateName.set_text($BaseSM.current_state.name)

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

# This function is used to put the player into motion.
# The reason why this function exists is to minimize amount of player calls in States.
func move():
	speed = min(speed + acceleration, speed_max)

func stop():
	speed = max(speed - deceleration, 0)
