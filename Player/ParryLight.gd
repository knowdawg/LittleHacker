extends PointLight2D


func hitEfect(_attack : Attack):
	$Sprite2D.rotation = randf_range(0, PI * 2.0)
	$AnimationPlayer.play("Flash")
