extends Node2D

@export var texture : Texture2D
@export var energy : float = 1.0
@export var color : Color = Color.WHITE

func _ready() -> void:
	if texture:
		%Shadows.texture = texture
		%Normal.texture = texture
	%Shadows.energy = energy / 2.0
	%Normal.energy = energy / 2.0
	
	%Shadows.color = color
	%Normal.color = color
