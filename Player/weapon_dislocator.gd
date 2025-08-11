extends Node2D

@export var parent : Node2D

func _process(_delta: float) -> void:
	position = -parent.global_position
