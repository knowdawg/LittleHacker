extends State

@export var sm : CrystalEliteStateMachine
@export var spriteDirector : SpriteDirectorComponent

@export_group("Animation")
@export var animator : AnimationPlayer
@export var animationName : String = ""

enum ATTACKS {SPIN, SLASH}
var prevAttack : ATTACKS = ATTACKS.SPIN

enum DIS {CLOSE, MEDIUM, FAR, FARFAR}
var disToPlayer : DIS

var nextStates : Array[String] = []

func enter(_prevState):
	animator.play(animationName)
	randomize()

var cornerAttack : int = 0
func update(_delta):
	spriteDirector.lookAtPlayer()
	
	#nextStates.append("RunningScoop")
	
	if nextStates.size() != 0:
		var nextState = nextStates.pop_front()
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
	
	if sm.stamina <= 0:
		nextStates.append("RegenStaminaSwordStance")
		sm.stamina += 5
		return
	
	var rand : int = prevAttack
	while rand == prevAttack:
		rand = randi_range(0, ATTACKS.size() - 1)
	
	if rand == ATTACKS.SPIN:
		prevAttack = ATTACKS.SPIN
		nextStates.append("SpinAttack")
		sm.stamina -= 3
		return
	
	if rand == ATTACKS.SLASH:
		prevAttack = ATTACKS.SLASH
		nextStates.append("DashDoubleSlash")
		sm.stamina -= 2
		return
		
