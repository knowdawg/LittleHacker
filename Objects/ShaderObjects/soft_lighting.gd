extends ColorRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_viewport().get_camera_2d():
		position = get_viewport().get_camera_2d().global_position + Vector2(-192.0/2.0, -108.0/2.0)
