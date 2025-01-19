extends Node

var hackCommands : Array[HackCommandComponent] = []

func _ready():
	Game.exitHackMode.connect(clearCommands)

func addCommand(c : HackCommandComponent):
	for h in hackCommands:
		if c == h:
			return
	hackCommands.append(c)

func clearCommands():
	hackCommands.clear()
