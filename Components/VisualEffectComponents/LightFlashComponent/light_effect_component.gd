extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2.ZERO

func hitEfect(_attack):
	$AnimationPlayer.play("Flash")
