extends CanvasLayer

@onready var textBox = $Text
@onready var entryBox = $Entry

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Game.inTerminal:
		entryBox.grab_focus()
	
	if Input.is_action_just_pressed("Terminal"):
		if !entryBox.has_focus():
			enter()
			
	if Input.is_action_just_pressed("SubmitTerminal"):
		if entryBox.has_focus():
			setCarrotToEnd()
			
			entryBox.backspace()
			var t = entryBox.get_text()
			t = t.to_lower()
			t = t.replace("/", "")
			var ogT = t
			t = autoCorrect(t)
			
			entryBox.clear()
			
			textBox.insert_line_at(textBox.get_line_count()-1, ogT)
			if !HackCommandManager.executeCommand(t):
				var h = HackCommandManager.executeTerminalCommand(t)
				textBox.insert_line_at(textBox.get_line_count()-1, h)
			else:
				textBox.insert_line_at(textBox.get_line_count()-1, "    Executing " + t + "...")
			exit()

func autoCorrect(s : String) -> String:
	var listOfWords : Array[String] = HackCommandManager.getCommandsNames()
	var distance : float = 0.24 #Also setves as a threshold
	var index = -1
	
	for i in listOfWords.size():
		var d = listOfWords[i].similarity(s)
		if d > distance:
			distance = d
			index = i
	
	if index == -1:
		return s
	
	return(listOfWords[index])


func setCarrotToEnd():
	textBox.set_caret_line(textBox.get_line_count()-1)
	textBox.set_caret_column(100)

func enter():
	Game.setTerminal(true)
	setCarrotToEnd()
	entryBox.insert_text_at_caret("/")
	$AnimationPlayer.play("Show")
	entryBox.grab_focus()


func exit():
	setCarrotToEnd()
	Game.setTerminal(false)
	entryBox.release_focus()
	$AnimationPlayer.play("Hide")
