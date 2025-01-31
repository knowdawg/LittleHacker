extends Node
class_name State

signal trasitioned

@export var updateWhileHacked : bool = false

func enter(_prevState):
	pass

func exit(_newState):
	pass

func update(_delta : float):
	pass

func update_physics(_delta: float):
	pass
