extends GenericTransitionState
class_name RemnantCrabGravityAmplification

@export var parent : RemnantCrab
@export var numOfReapeats : int = 4

@export var attackCom : AttackComponent

enum states {START, REPEAT, END}
var state : states = states.START

var amplificationCount : int = 0 #num of times ive been in this state

func customEnter(_prevState):
	state = states.START
	amplificationCount += 1

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
				animator.play("GravityAmplificationEnd")
				return
		states.END:
			
			if (t >= 1.0 + (1.4 * numOfReapeats) + 0.7) and (t <= 1.0 + (1.4 * numOfReapeats) + 1.8):
				parent.suckInPlayer(delta, 0.8)
			
			if t >= 1.0 + (1.4 * numOfReapeats) + 3.1:
				state = states.END
				trasitioned.emit(self, "Idle")
				return
	

func lightPillars():
	if amplificationCount > 1:
		parent.createLaserPillars(5)

func customExit(_n):
	attackCom.call_deferred("disable")
