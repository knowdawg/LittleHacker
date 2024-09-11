class_name Attack

var attack_damage : float = 0.0
var weakness_damage : float = 0.0
var knockback_force : float = 0.0
var attack_position : Vector2 = Vector2.ZERO
var knockback_vector : Vector2 = Vector2.ZERO
var parryPosition : Vector2 = Vector2.ZERO

var isParryable : bool = true
var isHazard : bool = false

var healthComponent : HealthComponent

var attackID : float = 0.0
