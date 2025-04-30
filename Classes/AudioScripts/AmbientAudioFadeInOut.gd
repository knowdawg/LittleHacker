extends AudioStreamPlayer

@export var volumeDB : float = 0.0

func _ready() -> void:
	volume_linear = 0.01
	var t : Tween = create_tween()
	t.set_ease(Tween.EASE_OUT)
	t.tween_property(self, "volume_db", volumeDB, 1.0)
	
	Game.littleViewport.onFadeInStart.connect(fadeOut)

func fadeOut() -> void:
	var t : Tween = create_tween()
	t.tween_property(self, "volume_linear", 0.01, 0.1)
