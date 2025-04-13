extends Area2D

func _on_body_entered(body):
	if body is Player:
		Game.platformingRespawnPos = get_spawn_pos()

func get_spawn_pos():
	if get_child_count() == 2:
		return get_node("Marker2D").global_position
	return Vector2.ZERO
