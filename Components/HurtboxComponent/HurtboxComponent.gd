extends Area2D
class_name HurtboxComponent

@export var stateMachine : StateMachine
@export var parrying : bool = false
@export var blocking : bool = false
@export var parryForgivenesTimer : Timer
signal parry(a : Attack)
signal blocked(a : Attack)
@export var health_componnet : HealthComponent
@export var IFRAMETIMER : float = 0.0
@export var isHackable = true

@export var isSolid : bool = true #for things like applyinh screenshake on hit ect
var ift : float = 0.0

var parryStrength = 0

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
	
	if attack.isHazard:
		health_componnet.damage(attack)
		return
	if attack.isGrabAttack:
		health_componnet.damage(attack)
		return
	if attack.isHackAttack and isHackable:
		if Game.hackedEnemy != null:
			return
		stateMachine.enterHackMode()
		return
	
	if parrying and attack.attackStrength <= parryStrength:
		parryStuff(attack)
		return
	if blocking and attack.attackStrength == 1:
		attackBlocked(attack)
		return
	attackBuffer = attack
	if parryForgivenesTimer:
		parryForgivenesTimer.start()
	else:
		damageStuff()

func parryStuff(attack : Attack):
	parry.emit(attack)

func attackBlocked(attack : Attack):
	blocked.emit(attack)

var attackBuffer : Attack
func damageStuff():
	if parrying == true and attackBuffer.attackStrength <= parryStrength:
		parryStuff(attackBuffer)
		return
	if blocking and attackBuffer.attackStrength == 1:
		attackBlocked(attackBuffer)
		return
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

func enable():
	$CollisionShape2D.disabled = false

func is_iframe_active():
	if ift >= 0:
		return true
	return false

func setIFrameTimer(val : float):
	ift = val

#strength of the parry
# 0 = no parry
# 1 = normal parry
# 2 = dash parry
# 3 = ...
func setParry(isParrying : bool, strength = 1):
	if isParrying:
		parrying = true
		parryStrength = strength
	else:
		parrying = false
		parryStrength = 0

func setBlock(isBlocking : bool):
	blocking = isBlocking
