@tool
extends Node2D

@export var viewportScale := Vector2(1.0, 1.0)

var active : bool = false

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	%InteractableArea.onInteract.connect(onInteract)

func onInteract():
	if !Game.doesBigCameraExist():
		printerr("No Big Camera Exists for Little Game Terminal")
		return
	
	active = true
	Game.inLittleGame = true
	
	if !Game.doesBigPlayerExist():
		printerr("No Big Player Found When Starting Terminal")
		return
	Game.bigPlayer.enterLittleGameMode()

func _process(_delta: float) -> void:
	$GameContainer.scale = viewportScale
	$Border.scale = viewportScale
	$Border2.scale = viewportScale
	%InteractableArea.scale = viewportScale
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
		Game.bigCamera.zoom = Vector2(1.0, 1.0) / (viewportScale * 5.0)
		

func leaveLittleGame():
	active = false
	Game.inLittleGame = false
	if Game.doesBigCameraExist():
		Game.bigCamera.reset()
	if Game.doesBigPlayerExist():
		Game.bigPlayer.leaveLittleGameMode()

func _unhandled_input(event: InputEvent) -> void:
	if !Game.inLittleGame:
		get_viewport().set_input_as_handled()
