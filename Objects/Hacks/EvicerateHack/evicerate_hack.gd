extends SwitchStateHack

@export var parent : CharacterBody2D
@export var damageTick : float = 3.0

func customExecute():
	$EvicerateAnimator.stop()
	$EvicerateAnimator.play("Evicerate")

func _process(_delta: float) -> void:
	$Node/Sprite2D.global_position = parent.global_position

func damageParent():
	var a = Attack.new()
	a.attack_damage = damageTick
	a.isParryable = false
	a.knockback_force = 30
	a.knockback_vector = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()
	
	healthComponent.damage(a)
