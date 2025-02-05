extends Node2D
class_name GenericLevel

@export var lighting : ColorRect
@export var lightingBrightness : float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if lighting:
		lighting.material.set_shader_parameter("brightness", lightingBrightness)
