extends Node2D

@export var speed : float = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vec = global_position - Game.player.global_position
	vec = -vec.normalized()
	position += vec * delta * speed
