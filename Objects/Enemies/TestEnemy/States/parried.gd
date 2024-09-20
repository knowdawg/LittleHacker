extends State

@export var parryLength : float = 0.0

@export_group("Next States")
@export var nextState : State

@export_group("Necesary Nodes")
@export var parrent : Node2D
@export var animator : AnimationPlayer
@export var movement : MovementComponent
@export var kbCom : OmniDirectionalKnockbackComponent

var t = 0.0
func enter():
	t = 0.0
	animator.play("Parried")
	movement.applyForce(kbCom.returnVecFromTwoObjects(parrent, Game.player), 30.0)
	
func update(delta):
	t += delta
	if t >= parryLength:
		trasitioned.emit(self, nextState.name)
