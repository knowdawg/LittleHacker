extends Line2D
class_name HackCommandComponent

@export var cost = 0.0
@export var hackName = ""
@export var healthComponent : HealthComponent

var font : Resource = preload("res://UI/5x5PixelFont.ttf")
var label : Label
func _ready() -> void:
	label = Label.new()
	label.add_theme_font_override("font", font)
	add_child(label)
	label.text = hackName

func setActive(isActive : bool):
	if isActive:
		default_color = "72bed3"
		label.add_theme_color_override("font_color", "72bed3")
	else:
		default_color = "ffffff"
		label.add_theme_color_override("font_color", "ffffff")

func isExecutable():
	return (healthComponent.get_weakness() >= cost)
