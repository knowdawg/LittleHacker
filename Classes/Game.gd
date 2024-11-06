extends Node

var player : Player

var inTerminal = false
signal terminalOn
signal terminalOff

var inHackMode = false
var hackedEnemy
signal enterHackMode
signal exitHackMode
var hacks : Array[HackCommandComponent] = []

var slowTimeTimer = 0.0
func slowTime(duration : float, timeScale : float):
	slowTimeTimer = duration  * timeScale
	Engine.time_scale = timeScale

func _process(delta: float) -> void:
	slowTimeTimer -= delta
	if inTerminal or inHackMode:
		Engine.time_scale = 0.1
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

func setHackMode(on : bool):
	if inHackMode != on:
		if on:
			inHackMode = true
			enterHackMode.emit()
		if !on:
			inHackMode = false
			exitHackMode.emit()
			hackedEnemy = null
			hacks = []
