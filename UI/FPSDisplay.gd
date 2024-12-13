extends Label



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "FPS: " + str(int((1.0 / delta) * Engine.time_scale))
