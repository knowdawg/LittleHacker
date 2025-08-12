extends ColorRect

func _ready() -> void:
	size = Vector2(192.0 + 2.0, 108.0 + 2.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_viewport().get_camera_2d():
		var c : Vector2 = get_viewport().get_camera_2d().get_screen_center_position()
		position = c + Vector2(-size.x/2.0, -size.y/2.0) - Vector2(0.5, 0.5) #Cuase imperfect
