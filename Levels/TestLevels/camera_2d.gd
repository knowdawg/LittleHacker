extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.camera = self

#func _process(delta: float) -> void:
	#print(global_position)
