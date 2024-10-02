extends Node

var player : Player

var inTerminal = false
signal terminalOn
signal terminalOff

var slowTimeTimer = 0.0
func slowTime(duration : float, timeScale : float):
	slowTimeTimer = duration  * timeScale
	Engine.time_scale = timeScale

func _process(delta: float) -> void:
	slowTimeTimer -= delta
	if inTerminal:
		Engine.time_scale = 0.3
	else:
		if slowTimeTimer < 0:
			Engine.time_scale = 1.0

func setTerminal(isOn : bool):
	
	if inTerminal != isOn:
		if isOn:
			inTerminal = true
			terminalOn.emit()
		if !isOn:
			inTerminal = false
			terminalOff.emit()
