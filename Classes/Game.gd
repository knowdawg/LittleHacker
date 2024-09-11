extends Node

var player : Player

var inTerminal = false

var slowTimeTimer = 0.0
func slowTime(duration : float, timeScale : float):
	slowTimeTimer = duration  * timeScale
	Engine.time_scale = timeScale


func _process(delta: float) -> void:
	slowTimeTimer -= delta
	if slowTimeTimer < 0:
		Engine.time_scale = 1.0
