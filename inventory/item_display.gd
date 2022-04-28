extends CenterContainer
class_name ItemDisplay

func populate(texture: Texture2D, quantity: int):
	var slot_texture : TextureRect = $PanelContainer/TextureRect
	var slot_quantity : Label = $PanelContainer/TextureRect/Label
	
	slot_texture.texture = texture
	slot_quantity.text = str(quantity)

