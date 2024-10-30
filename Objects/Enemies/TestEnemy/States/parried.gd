extends State
class_name GenericParriedState

@export var parryLength : float = 0.0
@export var animationName : String
@export var knockback : float = 30.0

@export_group("Next States")
@export var nextState : State

@export_group("Necesary Nodes")
@export var parrent : Node2D
@export var animator : AnimationPlayer
@export var movement : MovementComponent
@export var kbCom : OmniDirectionalKnockbackComponent

var t = 0.0
func enter(prevState):
	customEnter(prevState)
	t = 0.0
	animator.play(animationName)
	movement.applyForce(kbCom.returnVecFromTwoObjects(parrent, Game.player), knockback)

func update(delta):
	t += delta
	if t >= parryLength:
		trasitioned.emit(self, nextState.name)

func customEnter(_prevState):
	pass
