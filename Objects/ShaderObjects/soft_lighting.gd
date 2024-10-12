extends ColorRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_instance_valid(Game.player):
		position = Game.player.global_position + Vector2(-192.0/2.0, -108.0/2.0)
