extends RigidDynamicBody2D
class_name Entity

const SPEED := 300.0
@export_node_path(CharacterBody2D) var player 

const POSSIBLE_LOOT = [
	"White Bread",
	"Cheese Slice",
	"Meat Slab"
]

@onready var chosen_loot = POSSIBLE_LOOT[randi_range(0,POSSIBLE_LOOT.size()-1)]

func _ready():
	$Sprite2D.texture = ItemDatabase.get_item(chosen_loot).texture

# entities are moveable objects, different from actors in the way that 
# they have no semblance of sentience

# the main use for this right now is to make item entities.

func _physics_process(delta):
	apply_central_force(global_position.direction_to(player.global_position) * SPEED)

func _on_hitbox_body_entered(body):
	if body is Player:
		$Pickup.play()
		body.inventory.add_item(chosen_loot, 1)
		await $Pickup.finished
		queue_free()
