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
	
	var a = sm.getRandomAttack(prevAttack)
	#print(a)
	
	if a == sm.phase1Attacks.Stomp:
		#nextStates.append("Chase")
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
	
	if a == sm.phase1Attacks.SuckIn:
		nextStates.append("RunAway")
		nextStates.append("SuckIn")
		prevAttack = sm.phase1Attacks.SuckIn
		return
