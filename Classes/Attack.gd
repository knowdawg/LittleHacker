class_name Attack

var attack_damage : float = 0.0
var weakness_damage : float = 0.0
var attackStrength : int = 1
var attackName : String = ""
var knockback_force : float = 0.0
var attack_position : Vector2 = Vector2.ZERO
var knockback_vector : Vector2 = Vector2.ZERO
var parryPosition : Vector2 = Vector2.ZERO

var isParryable : bool = true
var isHazard : bool = false
var isHackAttack : bool = false
var isPogo : bool = false
var isGrabAttack : bool = false
var grabComponent : GrabComponent

enum SHARPNESS {SHARP, BLUNT, NIETHER = -1}
var attackType : SHARPNESS = SHARPNESS.NIETHER

var healthComponent : HealthComponent

var attackID : float = 0.0
