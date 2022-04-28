extends PlayerState

@export var walk : String
@export var dodge : String

var speed_previous : float

func _ready():
	super._ready()
	stamina.connect("burnout", _on_burnout)

func physics_update(_delta: float) -> void:
	player.update_direction()
	player.move()
	if (Input.is_action_just_released("run") 
		|| Input.get_vector("go_left", "go_right", "go_up", "go_down") == Vector2.ZERO):
		state_machine.change_state(walk)
	if Input.is_action_just_pressed("dodge"):
		state_machine.change_state(dodge)

# This overrides the default state behavior for stamina, and depletes it instead of increasing it.
# This is a much smarter approach seeing as depleting stamina is a special
func update_stamina(delta: float) -> void:
	stamina.deplete(delta)

func enter(_msg := {}):
	speed_previous = player.speed_base
	player.speed_base += player.run_modifier
	player.animation_state_machine.travel("Run")

func exit():
	player.speed_base = speed_previous

func _on_burnout():
	state_machine.change_state(walk)