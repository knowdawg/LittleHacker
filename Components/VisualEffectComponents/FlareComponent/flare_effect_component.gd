extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")

func hitEfect(_attack):
	$AnimationPlayer.play("Flare")
