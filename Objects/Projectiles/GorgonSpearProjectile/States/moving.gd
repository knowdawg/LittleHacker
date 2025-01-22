extends State
class_name GorgonSpearMovingState

@export var parent : CharacterBody2D
@export var attackComponent : AttackComponent
@export var parriedState : State
@export var collitionShape : CollisionShape2D
@export var sprite : Sprite2D
@export var animator : AnimationPlayer

var t = 0.
func enter(_prevState):
	attackComponent.generateAttackID()
	attackComponent.enable()
	animator.play("Throw")
	t = 0.0

func update_physics(delta):
	parent.velocity = parent.dirVector * parent.speed * delta
	collitionShape.rotation = parent.dirVector.angle()
	sprite.rotation = parent.dirVector.angle()
	var c : KinematicCollision2D = parent.move_and_collide(parent.velocity)
	t += delta
	if c and t > 0.15:
		parent.velocity = Vector2.ZERO
		trasitioned.emit(self, "Still")
	

func exit(_newState):
	attackComponent.call_deferred("disable")

func getParryState():
	return parriedState
