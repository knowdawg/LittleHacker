extends Area2D
class_name HurtboxComponent

@export var health_componnet : Node
@export var IFRAMETIMER : float = 0.0
var ift : float = 0.0

var spikesIfr : float = 0.0

var attackIDIveBeenHitBy = []

func _process(delta):
	ift -= delta
	spikesIfr -= delta

func damage(attack: Attack):
	for a in attackIDIveBeenHitBy:
		if attack.attackID == a:
			return
	attackIDIveBeenHitBy.append(attack.attackID)
	if ift >= 0.0:
		return
	ift = IFRAMETIMER
	if health_componnet:
		health_componnet.damage(attack)

func disable():
	$CollisionShape2D.disabled = true

func is_iframe_active():
	if ift >= 0:
		return true
	return false

func setIFrameTimer(val : float):
	ift = val
