extends Area2D
class_name AttackComponent

@export var attackName : String = ""
@export var collisionShape : Node2D
@export var healthComponent : HealthComponent
@export var disabled : bool = true

@export_group("Damage")
@export var attack_damage : float
@export var weakness_damage : float
@export var attackStrength : int = 1

@export_group("Knockback")
@export var knockback_force: float
@export var knockbackVector : Vector2

@export_group("Flags")
@export var isSpikes : bool = false
@export var isHackAttack : bool = false
@export var isPogo : bool = false
@export var isGrabAttack : bool = false
@export var grabNode : GrabComponent
@export var attackType : Attack.SHARPNESS = Attack.SHARPNESS.NIETHER

@export_group("Hit Effects")
@export var hitEfect : PackedScene
@export var numberOfHitEffect : int = 1
@export var screenShakeOnHit : float = 0.0

@onready var attackID : float = randf()

signal gotParried
signal grabSucessful
signal attackHit(area)

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
		attack.isPogo = isPogo
		attack.isGrabAttack = isGrabAttack
		attack.attackStrength = attackStrength
		attack.attackName = attackName
		attack.isHazard = isSpikes
		attack.attackType = attackType
		if healthComponent:
			attack.healthComponent = healthComponent
		
		attack.knockback_vector = knockbackVector
		
		if isGrabAttack:
			attack.grabComponent = grabNode
			grabSucessful.emit(attack)
		hurtbox.damage(attack)
		
		if isSpikes:
			generateAttackID()
		
		attackHit.emit(area)
		
		if hitEfect:
			for num in numberOfHitEffect:
				var e = hitEfect.instantiate()
				area.add_child(e)
				e.initialize(area.global_position)
		
		if area is HurtboxComponent:
			if area.isSolid:
				if Game.doesCameraExist():
					Game.camera.set_min_shake(screenShakeOnHit)


func generateAttackID():
	attackID = randf_range(0.0, 10000.0)

func disable():
	collisionShape.disabled = true

func enable():
	collisionShape.disabled = false

func readyAttack():
	attackID = randf_range(0.0, 10000.0)
	collisionShape.disabled = false

func parried(attack : Attack):
	if hurtboxSignal.is_connected(parried):
		hurtboxSignal.disconnect(parried)
	if healthComponent:
		healthComponent.set_weakness(healthComponent.get_weakness() + 3)
	call_deferred("disable")
	gotParried.emit(attack)

func _on_timer_timeout() -> void:
	if hurtboxSignal.is_connected(parried):
		hurtboxSignal.disconnect(parried)
