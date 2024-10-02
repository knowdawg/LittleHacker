extends Node

var hackCommands : Array[HackCommandComponent] = []
var activeCommands : Array[HackCommandComponent] = []

var terminalCommands : Array[String] = ["commands"]

var selectedHealthBar

func addCommand(c : HackCommandComponent):
	for h in hackCommands:
		if c == h:
			return
	hackCommands.append(c)

func removeCommand(c : HackCommandComponent):
	for i in hackCommands.size():
		if c == hackCommands[i]:
			hackCommands.remove_at(i)
			for j in activeCommands.size():
				if c == activeCommands[j]:
					activeCommands.remove_at(j)
					return
			return

func _process(_delta: float) -> void:
	for h in hackCommands:
		if activeCommands.has(h):
			if !h.isExecutable():
				activeCommands.erase(h)
		else:
			if h.isExecutable():
				activeCommands.append(h)

func executeCommand(commandName : String) -> bool:
	var n = commandName.to_lower()
	n = n.replace("/", "")
	for c in activeCommands:
		if c.hackName.to_lower() == n:
			c.executeHack()
			return true
	return false

func getCommandsNames():
	var commandNames : Array[String] = []
	for c in hackCommands:
		commandNames.append(c.hackName.to_lower())
	
	for n in terminalCommands:
		commandNames.append(n)
	
	return commandNames

func executeTerminalCommand(commandName : String) -> String:
	var n = commandName.to_lower()
	n = n.replace("/", "")
	
	if selectedHealthBar:
		var selectedEnemyCommands = selectedHealthBar.hackCommands
	
		for c in selectedEnemyCommands:
			if c.hackName.to_lower() == n:
				return "    Error: Not Enough Weakness"
	
	if n == "commands":
		var r = ""
		
		if !selectedHealthBar:
			return "    Error: No Commands Found"
		
		var selectedEnemyCommands = selectedHealthBar.hackCommands
		if selectedEnemyCommands.size() == 0:
			return "    Error: No Commands Found"
		
		for c in selectedEnemyCommands:
			r += "    " + c.hackName.to_lower() + ": Cost " + str(c.cost) + "\n"
		return r
	
	return "    Error: Command Not Found"
