extends GenericTransitionState

@export var parent : CharacterBody2D

func exit(_newState):
	parent.resonate()
