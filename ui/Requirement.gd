extends PanelContainer
class_name RequirementDisplay

func set_color(sufficient: bool) -> void:
	const VALID = Color("6db400") 
	const INVALID = Color("8c002a")

func set_data(title: String, current: int, full: int) -> void:
	$Data/Name.text = title
	$Data/Quantity.text = "%s/%s" % [current, full]
