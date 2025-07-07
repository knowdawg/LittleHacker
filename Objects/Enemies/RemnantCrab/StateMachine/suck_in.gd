extends State
class_name RamnantCrabSuckIn

@export var animator : AnimationPlayer
@export var length : float = 0.0
@export var suckStart : float = 0.0
@export var suckEnd : float = 0.0

@export var proximity : ProximityAreaComponent
@export var parent : CharacterBody2D

var t := 0.0
var gotPlayer := false

func enter(_p):
	t = 0.0
	gotPlayer = proximity.checkForPlayerInside()
	animator.play("SuckIn")

func update(delta):
	t += delta
	
	if !gotPlayer:
		trasitioned.emit(self, "Idle")
		return
	
	
	if t >= suckStart and t <= suckEnd:
		if Game.doesPlayerExist():
			Game.player.global_position.x = lerpf(Game.player.global_position.x, parent.global_position.x, delta * 5.0)
			if Game.doesCameraExist():
				Game.camera.set_min_shake(1.0)
			
	
	if t >= length:
		trasitioned.emit(self, "Idle")
		return

func exit(_n):
	gotPlayer = false
