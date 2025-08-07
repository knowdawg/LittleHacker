extends State
class_name RemnantCrabIdle

@export var sm : RemnantCrabStateMachine
@export var animator : AnimationPlayer

var prevAttack = -1
var nextStates : Array[String] = []

func enter(_p):
	animator.play("RESET")

func update(_delta):
	#nextStates.append("SuckIn")
	
	if nextStates.size() != 0:
		var nextState = nextStates.pop_front()
		if nextState == "Stomp":
			if sm.vectorToPlayer.x > 0:
				trasitioned.emit(self, "StompRight")
			else:
				trasitioned.emit(self, "StompLeft")
			return
		trasitioned.emit(self, nextState)
		return
	
	#nextStates.append("LaserRun")
	#nextStates.append("SuckIn")
	#nextStates.append("Jump")
	#return
	
	var a = sm.getRandomAttack(prevAttack)
	
	if abs(sm.xDisToPlayer) >= 60.0:
		if randf() < 0.5: #50% chance
			nextStates.append("SuckIn")
			prevAttack = sm.phase1Attacks.SuckIn
			return
	
	if a == sm.phase1Attacks.Stomp:
		if sm.xDisToPlayer > 0 and !sm.nearLeftWall:
			nextStates.append("RunAway")
		if sm.xDisToPlayer < 0 and !sm.nearRightWall:
			nextStates.append("RunAway")
		nextStates.append("Stomp")
		prevAttack = sm.phase1Attacks.Stomp
		return
	
	if a == sm.phase1Attacks.Jump:
		nextStates.append("Chase")
		nextStates.append("Jump")
		prevAttack = sm.phase1Attacks.Jump
		return
	
	if a == sm.phase1Attacks.HeadSlam:
		nextStates.append("Chase")
		nextStates.append("RunTowards")
		nextStates.append("HeadSlam")
		prevAttack = sm.phase1Attacks.HeadSlam
		return
	
	if a == sm.phase1Attacks.LazerRun:
		if sm.nearRightWall:
			return
		
		nextStates.append("LaserRun")
		prevAttack = sm.phase1Attacks.LazerRun
		return
	
