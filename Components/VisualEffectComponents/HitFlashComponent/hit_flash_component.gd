extends Node2D

enum type {CLIP, MODULATE}
@export var typeOFFlash : type = type.CLIP

@export var node : Node2D

func hitEfect(_attack : Attack):
	if typeOFFlash == type.CLIP:
		$AnimationPlayer.play("Animate")
	elif typeOFFlash == type.MODULATE:
		node.self_modulate = Color(100.0, 100.0, 100.0, 1.0);
		$Timer.start()


func _on_timer_timeout() -> void:
	node.self_modulate = Color(1.0, 1.0, 1.0, 1.0);
