extends State
class_name GenericEnemyDeath

@export_group("Required Nodes")
@export var animator : AnimationPlayer
@export var animationName : String
@export var hurtboxesToDisable : Array[HurtboxComponent]

@export_group("Optional Nodes")
@export var spriteDirectorComponent : SpriteDirectorComponent


func enter(prevState):
	if spriteDirectorComponent:
		spriteDirectorComponent.lookAtPlayer()
	animator.play(animationName)
	for h in hurtboxesToDisable:
		h.call_deferred("disable")
	customEnter(prevState)

func customEnter(_prevState):
	pass
