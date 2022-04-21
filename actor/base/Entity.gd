extends RigidDynamicBody2D
class_name Entity

const SPEED := 300.0
@export_node_path(CharacterBody2D) var player 

# entities are moveable objects, different from actors in the way that 
# they have no semblance of sentience

# the main use for this right now is to make item entities.

func _physics_process(delta):
	apply_central_force(global_position.direction_to(player.global_position) * SPEED)

func _on_hitbox_body_entered(body):
	if body is Player:
		$Pickup.play()
		await $Pickup.finished
		queue_free()
