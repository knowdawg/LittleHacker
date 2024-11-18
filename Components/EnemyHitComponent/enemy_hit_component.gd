extends Node2D
class_name OnHitComponent

@export var healthComponent : HealthComponent
@export var hitEffects : Array[Node2D] = []
@export var knockbackComponent : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if healthComponent:
		healthComponent.hit.connect(hit)
	else:
		printerr("OnHitComponent does not have a valid healthComponent")

func hit(attack : Attack):
	if hitEffects.size() > 0:
		for p in hitEffects:
			p.hitEfect(attack)
	if knockbackComponent:
		knockbackComponent.calculateKnockback(attack)
