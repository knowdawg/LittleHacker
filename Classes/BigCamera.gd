extends Camera2D
class_name BigCamera

func _ready() -> void:
	Game.bigCamera = self

func reset():
	zoom = Vector2(1.0, 1.0)
