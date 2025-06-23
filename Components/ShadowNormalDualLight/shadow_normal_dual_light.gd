@tool

extends Node2D

@export_tool_button("Update", "Callable") var update = updateLights

func _ready() -> void:
	updateLights()

func updateLights():
	%Shadows.texture = texture
	%Normal.texture = texture
	
	if lightsToUse == lights.Both:
		%Shadows.energy = energy * 0.5
		%Normal.energy = energy * 0.5
	if lightsToUse == lights.Shadows:
		%Shadows.energy = energy * 1.0
		%Normal.energy = energy * 0.0
	if lightsToUse == lights.Normal:
		%Shadows.energy = energy * 0.0
		%Normal.energy = energy * 1.0
	
	%Shadows.color = color
	%Normal.color = color
	
	%Shadows.offset = offset
	%Normal.offset = offset
	
	%Shadows.range_layer_min = layer
	%Shadows.range_layer_max = layer
	%Normal.range_layer_min = layer
	%Normal.range_layer_max = layer


@export var texture : Texture2D
@export var energy : float = 1.0
@export var color : Color = Color.WHITE
@export var offset : Vector2 = Vector2.ZERO
@export var layer : int = 0

enum lights {Shadows, Normal, Both = -1}
@export var lightsToUse : lights = lights.Both
