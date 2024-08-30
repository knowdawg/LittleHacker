extends Node2D

func initialize(_pos : Vector2):
	#position = pos
	rotation_degrees = randi()
	$AnimationPlayer.play("Animate")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
