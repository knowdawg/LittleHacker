extends Area2D
class_name AttackComponent

@export var collisionShape : Node2D
@export var hitEfect : PackedScene
@export var numberOfHitEffect : int = 1

@export var attack_damage : float
@export var weakness_damage : float
@export var knockback_force: float
@export var knockbackVector : Vector2
@export var isSpikes : bool = false
@export var disabled : bool = true

@onready var attackID : float = randf()

func _ready() -> void:
	if disabled:
		disable()

func _on_area_entered(area):
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.weakness_damage = weakness_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		attack.attackID = attackID
		
		attack.knockback_vector = knockbackVector
		
		hurtbox.damage(attack)
		
		if hitEfect:
			for num in numberOfHitEffect:
				var e = hitEfect.instantiate()
				area.add_child(e)
				e.initialize(area.global_position)
		
func generateAttackID():
	attackID = randf()

func disable():
	collisionShape.disabled = true

func enable():
	collisionShape.disabled = false
	generateAttackID()
