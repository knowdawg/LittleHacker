extends Area2D

@export var parent : Node2D

func getNearestRung(obj : Node2D, offset : float = 0.0):
	return parent.getNearestRung(obj, offset)
