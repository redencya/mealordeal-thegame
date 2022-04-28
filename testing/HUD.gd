extends Control
@export var health : Resource

func _ready():
	health.connect("health_changed", _on_health_changed)
	health.current = health.base
	$ProgressBar.max_value = health.base
	$ProgressBar.value = health.current

func _input(event):
	if event.is_action_pressed("inventory_open"):
		if $MenuBackdrop/AnimationPlayer.get_current_animation_position() > 0:
			$MenuBackdrop/AnimationPlayer.play_backwards("Summon")
		else:
			$MenuBackdrop/AnimationPlayer.play("Summon")

func _on_button_pressed():
	health.current -= 1

func _on_button_2_pressed():
	health.current += 1

func _on_health_changed(new_health):
	$ProgressBar.value = new_health
