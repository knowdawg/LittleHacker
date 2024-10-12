extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("Animate")
