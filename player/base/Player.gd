extends Actor
class_name Player

@export var controller : Resource
@export var loadout : Resource

func _process(_delta: float) -> void:
	$StateName.set_text($BaseSM.current_state.name)

func _physics_process(_delta: float) -> void:
	print(controller.speed.deceleration)
	velocity = direction * controller.speed.current
	move_and_slide()
