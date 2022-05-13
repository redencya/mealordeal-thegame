extends PanelContainer
class_name RequirementDisplay

func set_color(sufficient: bool) -> void:
	const COLOR_VALID = Color("6db400") 
	const COLOR_INVALID = Color("8c002a")
	$Color.set_color(COLOR_VALID if sufficient else COLOR_INVALID)

func set_data(title: String, current: int, full: int) -> void:
	$Margin/Data/Name.text = title
	$Margin/Data/Quantity.text = "%s/%s" % [current, full]
