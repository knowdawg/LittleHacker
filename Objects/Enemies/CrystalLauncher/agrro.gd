extends State

@export var parent : CrystalLauncher
@export var sprite : Sprite2D
@export var animator : AnimationPlayer
@export var timeInState : float = 2.0
@export var rayCast : RayCast2D

var lookRightAngle : float = PI
var lookUpRightAngle : float = 4.0 * PI / 6.0
var lookUpLeftAngle : float = 2.0 * PI / 6.0
var lookLeftAngle : float = 0

enum lookDir {R, UR, UL, L}

func enter(_prevState):
	animator.play("Agro")
	curDirection = getClosestAngle(parent.dirToPlayer)
	t = 0.0

var nextFrameTimer : float = 0.0
var curDirection = lookDir.R
var t = 0.0
var launchDelay = 0.0
func update(delta):
	curDirection = getClosestAngle(parent.dirToPlayer)
	
	#later, if I feel like it, I can add in the inbetweens
	if curDirection == lookDir.R:
		sprite.frame = 12
		
	if curDirection == lookDir.UR:
		sprite.frame = 10
		
	if curDirection == lookDir.UL:
		sprite.frame = 8
		
	if curDirection == lookDir.L:
		sprite.frame = 6
	
	
	t += delta
	if Game.doesPlayerExist():
		rayCast.look_at(Game.player.global_position)
		if rayCast.is_colliding():
			if t >= timeInState and rayCast.get_collider() is Player:
				launchDelay = 0.2
				t = 0.0
				return
	
	if launchDelay > 0.0:
		if t > launchDelay:
			launchDelay = 0.0
			trasitioned.emit(self, "Launch")


func getClosestAngle(angle) -> lookDir:
	var minDis = abs(lookRightAngle - angle)
	var closestAngle = lookDir.R
	
	if abs(lookUpRightAngle - angle) < minDis:
		minDis = abs(lookUpRightAngle - angle)
		closestAngle = lookDir.UR
	if abs(lookUpLeftAngle - angle) < minDis:
		minDis = abs(lookUpLeftAngle - angle)
		closestAngle = lookDir.UL
	if abs(lookLeftAngle - angle) < minDis:
		minDis = abs(lookLeftAngle - angle)
		closestAngle = lookDir.L
	
	return closestAngle
