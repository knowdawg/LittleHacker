extends ColorRect


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.camera:
		var pos = Game.camera.global_position * 0.001
		material.set_shader_parameter("cameraPos", Vector3(pos.x - 0.9, 0.0, 0.0))
