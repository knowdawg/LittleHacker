extends Line2D

@export var startOnReady : bool = false


func _ready() -> void:
	if startOnReady:
		$AnimationPlayer.play("Strike")
