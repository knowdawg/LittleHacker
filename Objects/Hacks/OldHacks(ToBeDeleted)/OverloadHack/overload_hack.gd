extends Node2D


# Called when the node enters the scene tree for the first time.
func initialize():
	$AnimationPlayer.play("Hack")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
