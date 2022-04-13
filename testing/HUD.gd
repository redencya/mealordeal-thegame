extends Control

@export_node_path(CharacterBody2D) var player_path
@onready var player = get_node(player_path)
@export var health : Resource

func _ready():
	health.connect("health_changed", _on_health_changed)
	health.current = health.base
	$ProgressBar.max_value = health.base
	$ProgressBar.value = health.current

func _process(_delta):
	$Prompt.visible = player.near_storage
	if player.near_storage && Input.is_action_just_pressed("inventory_open"):
		$MenuBackdrop.visible = !$MenuBackdrop.visible 
		player.process_mode = (Node.PROCESS_MODE_DISABLED
		if player.process_mode == Node.PROCESS_MODE_PAUSABLE 
		else Node.PROCESS_MODE_PAUSABLE)

func _on_button_pressed():
	health.current -= 1

func _on_button_2_pressed():
	health.current += 1

func _on_health_changed(new_health):
	$ProgressBar.value = new_health