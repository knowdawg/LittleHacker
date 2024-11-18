extends Node2D

@export var hurtBoxToIntercept : HurtboxComponent
@export var efects : Array[Node] = []
@export var parent : Node2D

func _ready() -> void:
	if hurtBoxToIntercept:
		hurtBoxToIntercept.parry.connect(parry)

func parry(attack : Attack):
	for e in efects:
		e.hitEfect(attack)
	
	if parent:
		parent.parry(attack)
