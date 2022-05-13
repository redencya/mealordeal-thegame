extends CenterContainer
class_name ItemDisplay

@onready var slot_texture : TextureRect = $PanelContainer/TextureRect
@onready var default_texture = slot_texture.texture
@onready var slot_quantity : Label = $PanelContainer/TextureRect/Label
@onready var default_quantity = slot_quantity.text

func reset():
	slot_texture.texture = default_texture
	slot_quantity.text = default_quantity

func populate(texture: Texture2D, quantity: int):
	slot_texture.texture = texture
	slot_quantity.text = str(quantity)

