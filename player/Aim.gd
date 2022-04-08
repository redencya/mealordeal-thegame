# The Aim script is meant to be used as the input implementation of the Shooter behaviors.
# It exists so that the main player script can execute primarily movement-centric logic,
# delegating this task to the more fitting Node component.

extends Node

@onready var gun : Gun = get_parent()

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		gun.spawn_bullet_relative_to(get_viewport().get_mouse_position())
