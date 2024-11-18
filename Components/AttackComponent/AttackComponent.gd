extends Area2D
class_name AttackComponent

@export var collisionShape : Node2D
@export var hitEfect : PackedScene
@export var numberOfHitEffect : int = 1

@export var attack_damage : float
@export var weakness_damage : float
@export var attackStrength : int = 1
@export var knockback_force: float
@export var knockbackVector : Vector2
@export var attackName : String = ""
@export var isSpikes : bool = false
@export var disabled : bool = true
@export var isHackAttack : bool = false

@export var healthComponent : HealthComponent

@onready var attackID : float = randf()

signal gotParried

func _ready() -> void:
	if disabled:
		disable()

var hurtboxSignal : Signal
func _on_area_entered(area):
	if area is HurtboxComponent:
		hurtboxSignal = area.parry
		if !hurtboxSignal.is_connected(parried):
			hurtboxSignal.connect(parried)
			$Timer.start()
		
		var hurtbox : HurtboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.weakness_damage = weakness_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		attack.attackID = attackID
		attack.attackName = attackName
		attack.isHackAttack = isHackAttack
		attack.attackStrength = attackStrength
		if healthComponent:
			attack.healthComponent = healthComponent
		
		attack.knockback_vector = knockbackVector
		
		if isHackAttack:
			if Game.hackedEnemy == null and hurtbox.enterHack(attack):
				Game.setHackMode(true)
			return
		
		hurtbox.damage(attack)
		
		if hitEfect:
			for num in numberOfHitEffect:
				var e = hitEfect.instantiate()
				area.add_child(e)
				e.initialize(area.global_position)
		
		
func generateAttackID():
	attackID = randf_range(0.0, 10000.0)

func disable():
	collisionShape.disabled = true

func enable():
	collisionShape.disabled = false

func parried(attack : Attack):
	if hurtboxSignal.is_connected(parried):
		hurtboxSignal.disconnect(parried)
	call_deferred("disable")
	gotParried.emit(attack)

func _on_timer_timeout() -> void:
	if hurtboxSignal.is_connected(parried):
		hurtboxSignal.disconnect(parried)
