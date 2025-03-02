extends State

@export var sm : AspectOfCreationStateMachine
@export var spriteDirector : SpriteDirectorComponent

@export_group("Animation")
@export var animator : AnimationPlayer
@export var animationName : String = ""

enum ATTACKS {PUNCH, SCOOP, SLAM, GRAB}
var prevAttack : ATTACKS = ATTACKS.SLAM

enum DIS {CLOSE, MEDIUM, FAR, FARFAR}
var disToPlayer : DIS

var nextStates : Array[String] = []

func enter(_prevState):
	animator.play(animationName)
	randomize()

func update(_delta):
	spriteDirector.lookAtPlayer()
	
	#nextStates.append("RunningScoop")
	
	if nextStates.size() != 0:
		var nextState = nextStates.pop_front()
		if sm.isLeftBoundryColliding() and sm.dirToPlayer == sm.DIRECTION.LEFT:
			if nextState == "Grab" or nextState == "Slam":
				nextStates = []
				return
		if sm.isRightBoundryColliding() and sm.dirToPlayer == sm.DIRECTION.RIGHT:
			if nextState == "Grab" or nextState == "Slam":
				nextStates = []
				return
		trasitioned.emit(self, nextState)
		return
		
	if sm.distToPlayer <= 5:
		disToPlayer = DIS.CLOSE
	elif sm.distToPlayer <= 20:
		disToPlayer = DIS.MEDIUM
	elif sm.distToPlayer <= 40:
		disToPlayer = DIS.FAR
	else:
		disToPlayer = DIS.FARFAR
	
	var rand : int = prevAttack
	while rand == prevAttack:
		rand = randi_range(0, ATTACKS.size() - 1)
	
	if rand == ATTACKS.PUNCH:
		prevAttack = ATTACKS.PUNCH
		print("punch")
		if disToPlayer == DIS.FAR:
			nextStates.append("RunningPunch")
			return
		if disToPlayer == DIS.FARFAR:
			nextStates.append("RunTowardsPlayer")
			nextStates.append("Punch")
			return
		nextStates.append("Punch")
		return
	
	if rand == ATTACKS.SCOOP:
		prevAttack = ATTACKS.SCOOP
		print("Scoop")
		if disToPlayer == DIS.FAR or disToPlayer == DIS.MEDIUM:
			nextStates.append("Scoop")
			return
		if disToPlayer == DIS.FARFAR:
			nextStates.append("RunningScoop")
			return
		nextStates.append("RunAwayFromPlayer")
		nextStates.append("Scoop")
		return
		
	if rand == ATTACKS.SLAM:
		prevAttack = ATTACKS.SLAM
		print("slam")
		if disToPlayer == DIS.FAR or disToPlayer == DIS.FARFAR:
			nextStates.append("RunTowardsPlayer")
			nextStates.append("Slam")
			return
		#refuse if to close to a wall
		nextStates.append("Slam")
		return
		
	if rand == ATTACKS.GRAB:
		prevAttack = ATTACKS.GRAB
		print("grab")
		if disToPlayer == DIS.FAR or disToPlayer == DIS.FARFAR:
			nextStates.append("RunTowardsPlayer")
			nextStates.append("Grab")
			return
		nextStates.append("Grab")
