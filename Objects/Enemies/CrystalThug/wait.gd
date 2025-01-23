extends GenericTransitionState

@export var spriteDirector : SpriteDirectorComponent

func customEnter(_prevState):
	length = randf_range(0.0, 0.5)

func customUpdate(_delta):
	spriteDirector.lookAtPlayer()
