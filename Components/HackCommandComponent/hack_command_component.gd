extends Line2D
class_name HackCommandComponent

@export var cost = 0.0
@export var hackName = ""
@export var healthComponent : HealthComponent

@onready var label : Label = $Label

signal executed

var enabled : bool = true

#func setActive(isActive : bool):
	#label.text = hackName
	#label.position = points[points.size()-1] + Vector2(-5.0, 0.0)
	#if isActive:
		#default_color = "72bed3"
		#label.add_theme_color_override("font_color", "72bed3")
	#else:
		#default_color = "ffffff"
		#label.add_theme_color_override("font_color", "ffffff")

func isExecutable():
	return (healthComponent.get_weakness() >= cost and enabled)

func execute():
	executed.emit()
	healthComponent.set_weakness(healthComponent.get_weakness() - cost)
	executeHack()

#Used for manualy setting if a hack can be used
func disable():
	enabled = false

func enable():
	enabled = true

func executeHack():
	pass
