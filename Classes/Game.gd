extends Node

var player : Player
var camera : Camera2D
var level : Node2D

var inTerminal = false
signal terminalOn
signal terminalOff

var inHackMode = false
var hackedEnemy = null
signal enterHackMode
signal exitHackMode

func slowTime(duration : float, timeScale : float):
	Engine.time_scale = timeScale

func _process(delta: float) -> void:
	if inHackMode:
		Engine.time_scale = move_toward(Engine.time_scale, 0.1, delta * 60.0)
	else:
		Engine.time_scale = move_toward(Engine.time_scale, 1.0, delta * 5.0)

func setHackMode(on : bool):
	if inHackMode != on:
		if on:
			inHackMode = true
			enterHackMode.emit()
		if !on:
			inHackMode = false
			exitHackMode.emit()
			hackedEnemy = null
