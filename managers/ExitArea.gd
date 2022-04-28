extends Area2D
class_name ExitArea2D

@export_file var target_scene

func ready():
  connect("body_entered",  _on_exit_area_body_entered)

func _on_exit_area_body_entered(body: Node) -> void:
  if body is Player:
    get_tree().change_scene(target_scene)
