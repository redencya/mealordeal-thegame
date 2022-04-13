extends Actor
class_name Player

@export var controller : Resource
@export var loadout : Resource
@onready var sprite : AnimatedSprite2D = $Sprite

var near_storage : bool = false


#func _ready():
#	health.connect("health_changed", _on_health_changed)

func _process(_delta: float) -> void:
	$Interact/Collider.rotation = direction.angle() - deg2rad(90)
	$StateName.set_text($BaseSM.current_state.name)

func _physics_process(_delta: float) -> void:
	velocity = controller.compute_velocity(direction)
	move_and_slide()

#func _on_health_changed(_new_health):
#	if not invulnerable:
#		$StateMachine.change_state("Flinch")

func _on_interact_body_entered(body:Node2D):
	if body is Entity:
		near_storage = true

func _on_interact_body_exited(body:Node2D):
	if body is Entity:
		near_storage = false