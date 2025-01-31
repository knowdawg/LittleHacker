extends Line2D
class_name HackCommandComponent

@export var cost = 0.0
@export var hackName = ""
@export var healthComponent : HealthComponent

@onready var label : Label = $Label

func setActive(isActive : bool):
	label.text = hackName
	label.position = points[points.size()-1] + Vector2(-5.0, 0.0)
	if isActive:
		default_color = "72bed3"
		label.add_theme_color_override("font_color", "72bed3")
	else:
		default_color = "ffffff"
		label.add_theme_color_override("font_color", "ffffff")

func isExecutable():
	return (healthComponent.get_weakness() >= cost)

func executeHack():
	pass
