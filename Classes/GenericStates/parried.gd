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
@export var biDirectionalKbCom : BiDirectionalKnockbackComponent

@export_group("KnockbackBasedOnSpriteDirection")
@export var knockbackBasedOnDir : bool = false
@export var sprite : Sprite2D


var t = 0.0
func enter(prevState):
	customEnter(prevState)
	t = 0.0
	animator.play(animationName)
	if knockbackBasedOnDir:
		if sprite.flip_h:
			movement.applyForce(Vector2(-1, 0), knockback)
		else:
			movement.applyForce(Vector2(1, 0), knockback)
	else:
		if !kbCom:
			movement.applyForce(biDirectionalKbCom.returnVecFromTwoObjects(parrent, Game.player), knockback)
		else:
			movement.applyForce(kbCom.returnVecFromTwoObjects(parrent, Game.player), knockback)

func update(delta):
	t += delta
	if t >= parryLength:
		trasitioned.emit(self, nextState.name)

func customEnter(_prevState):
	pass
