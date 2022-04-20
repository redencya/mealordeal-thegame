extends Node2D

@export_node_path(Node) var target_path
const ENEMY = preload("res://npc/base/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.text = "Next enemy in: " + str(floor($Timer.time_left))

func _on_timer_timeout():
	var enemy = ENEMY.instantiate()
	enemy.health.base = randi_range(3, 6)
	enemy.health.current = enemy.health.base
	enemy.global_position = global_position 
	enemy.target = get_node(target_path)
	get_tree().get_root().add_child(enemy)
	
	$Timer.start()
