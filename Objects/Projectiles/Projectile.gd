extends Node2D
class_name Projectile

@export var numOfPierces : int = 999
@export var destroyOnTerrain : bool = true

var dirVector : Vector2 = Vector2(1.0, 0.0)
@export var speed : float = 1.0
var flipH : bool = false
var flipV : bool = false
@export var friendly = false

var healthComponent : HealthComponent #For making the projectiles build up weakness
@export var attackComponents : Array[AttackComponent]

@export_group("AttackComponentDelay")
@export var delay : float = 0.0
@export var delayTimer : Timer
@export var attackComponent : AttackComponent



func _ready() -> void:
	delayAttackComponent()
	for a in attackComponents:
		if healthComponent:
			a.healthComponent = healthComponent
	customReady()

func customReady():
	pass

func delayAttackComponent() -> void:
	if !attackComponent:
		return
	if delay == 0.0:
		enableAttackComponent()
	else:
		if delayTimer:
			delayTimer.timeout.connect(enableAttackComponent)
			delayTimer.start(delay)
			

func enableAttackComponent():
	if attackComponent:
		attackComponent.call_deferred("enable")

func move(dir : Vector2, s : float, delta):
	position += dir * s * delta

func setFriendly(_f : bool):
	pass
