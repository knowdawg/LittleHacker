extends Node2D

@export var hurtBoxToIntercept : HurtboxComponent
@export var efects : Array[Node] = []
@export var parent : Node2D
@export var sounds : Array[AudioStreamPlayer] = []

func _ready() -> void:
	if hurtBoxToIntercept:
		hurtBoxToIntercept.parry.connect(parry)

func parry(attack : Attack):
	for e in efects:
		e.hitEfect(attack)
	
	if parent:
		parent.parry(attack)
		
	for s in sounds:
		s.pitch_scale = 1.0 + randf_range(-0.1, 0.1)
		s.play()
