extends Control

func _on_settings_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()

func _on_launch_pressed():
	get_tree().change_scene("res://world/demo_game.tscn")
