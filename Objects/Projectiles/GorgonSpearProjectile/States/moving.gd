extends State

@export var parent : CharacterBody2D
@export var attackComponent : AttackComponent
@export var parriedState : State
@export var collitionShape : CollisionShape2D

func enter(_prevState):
	attackComponent.generateAttackID()
	attackComponent.enable()

func update_physics(delta):
	parent.velocity = parent.dirVector * parent.speed * delta
	collitionShape.rotation = parent.dirVector.angle()
	var c : KinematicCollision2D = parent.move_and_collide(parent.velocity)
	if c:
		parent.velocity = Vector2.ZERO
		trasitioned.emit(self, "Still")
	

func exit(_newState):
	attackComponent.call_deferred("disable")

func getParryState():
	return parriedState
