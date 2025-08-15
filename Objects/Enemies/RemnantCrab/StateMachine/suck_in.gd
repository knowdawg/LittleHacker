extends State
class_name RamnantCrabSuckIn

@export var animator : AnimationPlayer
@export var laserAnimator : AnimationPlayer
@export var length : float = 0.0
@export var suckStart : float = 0.0
@export var suckEnd : float = 0.0

@export var proximity : ProximityAreaComponent
@export var parent : RemnantCrab

var t := 0.0
var gotPlayer := false

func enter(_p):
	t = 0.0
	gotPlayer = proximity.checkForPlayerInside()
	animator.play("SuckIn")
	laserAnimator.play("RESET")

func update(delta):
	t += delta
	
	if !gotPlayer:
		trasitioned.emit(self, "Idle")
		return
	
	
	if t >= suckStart and t <= suckEnd:
		parent.suckInPlayer(delta, 5.0)
			
	
	if t >= length:
		trasitioned.emit(self, "Idle")
		return

func exit(_n):
	gotPlayer = false
	laserAnimator.play("RESET")
