extends GenericTransitionState
class_name RemnantCrabGravityAmplification

@export var parent : RemnantCrab
@export var numOfReapeats : int = 4

@export var attackComs : Array[AttackComponent]
@export var hurtboxCom : HurtboxComponent

enum states {START, REPEAT, END}
var state : states = states.START

var amplificationCount : int = 0 #num of times ive been in this state

func customEnter(_prevState):
	state = states.START
	amplificationCount += 1
	hurtboxCom.isHackable = false

func customUpdate(delta):
	match state:
		states.START:
			
			
			if t>= 1.0:
				state = states.REPEAT
				animator.play("GravityAmplificationRepeat")
				return
		states.REPEAT:
			
			parent.suckInPlayer(delta, 0.4)
			
			if t >= 1.0 + (1.4 * numOfReapeats):
				state = states.END
				if amplificationCount >= 2:
					trasitioned.emit(self, "Death")
					return
				animator.play("GravityAmplificationEnd")
				return
		states.END:
			
			if (t >= 1.0 + (1.4 * numOfReapeats) + 0.7) and (t <= 1.0 + (1.4 * numOfReapeats) + 1.8):
				parent.suckInPlayer(delta, 0.8)
			
			if t >= 1.0 + (1.4 * numOfReapeats) + 3.1:
				trasitioned.emit(self, "Idle")
				return
	

func lightPillars():
	if amplificationCount > 1:
		parent.createLaserPillars(5)

func customExit(_n):
	hurtboxCom.isHackable = true
	for c in attackComs:
		c.call_deferred("disable")
