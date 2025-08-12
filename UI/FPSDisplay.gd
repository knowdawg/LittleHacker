extends Label



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "FPS: " + str(Engine.time_scale  * 1.0 / delta).pad_decimals(2)
