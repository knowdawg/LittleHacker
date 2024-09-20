extends Area2D
class_name HurtboxComponent

@export var parrying : bool = false
@export var parryForgivenesTimer : Timer
signal parry
@export var health_componnet : HealthComponent
@export var IFRAMETIMER : float = 0.0
var ift : float = 0.0

var spikesIfr : float = 0.0

var attackIDIveBeenHitBy = []

func _process(delta):
	ift -= delta
	spikesIfr -= delta

func damage(attack: Attack):
	if parrying:
		parryStuff(attack)
		return
	attackBuffer = attack
	if parryForgivenesTimer:
		parryForgivenesTimer.start()
	else:
		damageStuff()

func parryStuff(attack : Attack):
	parry.emit(attack)
	attackIDIveBeenHitBy.append(attack.attackID)
	if attack.healthComponent:
		attack.healthComponent.set_weakness(attack.healthComponent.get_weakness() + 3)

var attackBuffer : Attack
func damageStuff():
	if parrying == true:
		parryStuff(attackBuffer)
		return
	for a in attackIDIveBeenHitBy:
		if attackBuffer.attackID == a:
			return
	attackIDIveBeenHitBy.append(attackBuffer.attackID)
	if ift >= 0.0:
		return
	ift = IFRAMETIMER
	if health_componnet:
		health_componnet.damage(attackBuffer)

func _ready() -> void:
	if parryForgivenesTimer:
		parryForgivenesTimer.timeout.connect(damageStuff)

func disable():
	$CollisionShape2D.disabled = true

func is_iframe_active():
	if ift >= 0:
		return true
	return false

func setIFrameTimer(val : float):
	ift = val
