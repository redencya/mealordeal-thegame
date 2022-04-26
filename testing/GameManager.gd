extends Node2D

@export_node_path(CharacterBody2D) var player_path
@onready var player : Player = get_node(player_path)

func _ready():
	var player_inventory = player.inventory as Inventory
	player_inventory.connect("inventory_changed", _on_inventory_changed)

func _on_inventory_changed() -> void:
	pass
