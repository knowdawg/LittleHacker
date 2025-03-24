extends Node

var hackCommands : Array[HackCommandComponent] = []

func _ready():
	Game.exitHackMode.connect(clearCommands)

func _process(_delta: float) -> void:
	if Game.littleViewport:
		var s = Game.littleViewport.onSceneExit
		if !s.is_connected(levelSwiched):
			s.connect(levelSwiched)

func levelSwiched(_sceneData):
	clearCommands()

func addCommand(c : HackCommandComponent):
	for h in hackCommands:
		if c == h:
			return
	hackCommands.append(c)

func clearCommands():
	hackCommands.clear()
