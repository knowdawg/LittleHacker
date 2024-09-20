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
			entryBox.clear()
			
			var t = entryBox.text
			t = t.to_lower()
			t = t.replace("/", "")
			print("Test" + t)
			textBox.insert_line_at(textBox.get_line_count()-1, t)
			if !HackCommandManager.executeCommand(t):
				var h = HackCommandManager.executeTerminalCommand(t)
				textBox.insert_line_at(textBox.get_line_count()-1, h)
			else:
				textBox.insert_line_at(textBox.get_line_count()-1, "    Executing " + t + "...")
			exit()

func setCarrotToEnd():
	textBox.set_caret_line(textBox.get_line_count()-1)
	textBox.set_caret_column(100)

func enter():
	Game.inTerminal = true
	setCarrotToEnd()
	entryBox.insert_text_at_caret("/")
	$AnimationPlayer.play("Show")
	entryBox.grab_focus()

func exit():
	setCarrotToEnd()
	Game.inTerminal = false
	entryBox.release_focus()
	$AnimationPlayer.play("Hide")
