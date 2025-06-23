@tool

extends Node2D

@export_tool_button("Update", "Callable") var update = updateLights

func _ready() -> void:
	updateLights()

func updateLights():
	%Shadows.texture = texture
	%Normal.texture = texture
	
	%Shadows.energy = energy * 0.5
	%Normal.energy = energy * 0.5
	
	%Shadows.color = color
	%Normal.color = color
	
	%Shadows.offset = offset
	%Normal.offset = offset


@export var texture : Texture2D
@export var energy : float = 1.0
@export var color : Color = Color.WHITE
@export var offset : Vector2 = Vector2.ZERO
