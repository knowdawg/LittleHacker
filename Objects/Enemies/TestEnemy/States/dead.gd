extends State
class_name GenericEnemyDeath

@export var animator : AnimationPlayer
@export var animationName : String
@export var hurtboxesToDisable : Array[HurtboxComponent]

@export_group("Optional Nodes")
@export var spriteDirectorComponent : SpriteDirectorComponent

func enter(_prevState):
	if spriteDirectorComponent:
		spriteDirectorComponent.lookAtPlayer()
	animator.play(animationName)
	for h in hurtboxesToDisable:
		h.call_deferred("disable")
