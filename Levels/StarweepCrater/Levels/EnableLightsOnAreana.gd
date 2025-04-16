extends Node2D

func _ready() -> void:
	%EnemyWaveManager.onStartEncounter.connect(start)
	%EnemyWaveManager.onEndEncounter.connect(end)
	
	for c : Light2D in get_children():
		c.scale = Vector2(0, 0)

var dir : float = 0.0

func start():
	dir = 1.3

func end():
	t = 16
	dir = -0.1

var t : float = 0.0
func _process(delta: float) -> void:
	t += delta * dir * 10.0
	
	var val = clamp(t - 15.0, 0.0, 1.0)
	
	for c : Light2D in get_children():
		c.scale = Vector2(1.0, 1.0)
		c.color = Color(0.25, 0.25, 0.25, 1.0) * val
