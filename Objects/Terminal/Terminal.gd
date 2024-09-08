extends TextEdit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Game.inTerminal:
		grab_focus()
	
	if Input.is_action_just_pressed("Terminal"):
		if !has_focus():
			enter()
			
	if Input.is_action_just_pressed("SubmitTerminal"):
		if has_focus():
			setCarrotToEnd()
			var line = get_line(get_line_count()-2)
			
			if !HackCommandManager.executeCommand(line):
				var h = HackCommandManager.executeTerminalCommand(line)
				insert_line_at(get_line_count()-1, h)
			else:
				var l = line.to_lower()
				l = l.replace("/", "")
				insert_line_at(get_line_count()-1, "    Executing " + l + "...")
			exit()

func setCarrotToEnd():
	set_caret_line(get_line_count()-1)
	set_caret_column(100)

func enter():
	Game.inTerminal = true
	setCarrotToEnd()
	insert_text_at_caret("/")
	$AnimationPlayer.play("Show")
	grab_focus()

func exit():
	setCarrotToEnd()
	Game.inTerminal = false
	release_focus()
	$AnimationPlayer.play("Hide")
