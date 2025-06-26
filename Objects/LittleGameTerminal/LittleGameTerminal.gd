extends Node2D

var active : bool = false

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	%Desk.play("On")
	%InteractableArea.onInteract.connect(onInteract)

func onInteract():
	if !Game.doesBigCameraExist():
		printerr("No Big Camera Exists for Little Game Terminal")
		return
	
	active = true
	Game.setGameStatus(true, false)
	%Darken.visible = false
	
	if !Game.doesBigPlayerExist():
		printerr("No Big Player Found When Starting Terminal")
		return
	Game.bigPlayer.enterLittleGameMode()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if active:
		if !Game.doesBigCameraExist():
			leaveLittleGame()
			return
		if Input.is_action_just_pressed("LeaveLittleGame"):
			leaveLittleGame()
			return
		
		Game.bigCamera.global_position = global_position
		Game.bigCamera.zoom = Vector2(1.0, 1.0) / (0.022 * 5.0)
		

func leaveLittleGame():
	active = false
	Game.setGameStatus(false, true)
	%Darken.visible = true
	if Game.doesBigCameraExist():
		Game.bigCamera.reset()
	if Game.doesBigPlayerExist():
		Game.bigPlayer.leaveLittleGameMode()


func _on_interactable_area_on_select() -> void:
	%Desk.material.set_shader_parameter("width", 1.0)

func _on_interactable_area_on_de_select() -> void:
	%Desk.material.set_shader_parameter("width", 0.0)
