extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10.0
var health : float

@export var MAX_WEAKNESS := 20.0
var weakness : float = 0.0

@export var locked = false


signal death(attack : Attack)
signal hit(attack : Attack)
signal grabbed(attack : Attack)

func _ready():
	health = MAX_HEALTH

func get_health():
	return health

func get_max_health():
	return MAX_HEALTH

func set_max_health(value : float):
	MAX_HEALTH = value

func set_health(val : float):
	if val > MAX_HEALTH:
		health = MAX_HEALTH
	else:
		health = val

func get_weakness():
	return weakness

func get_max_weakness():
	return MAX_WEAKNESS

func set_max_weakness(val : float):
	MAX_WEAKNESS = val

func set_weakness(val : float):
	if val > MAX_WEAKNESS:
		weakness = MAX_WEAKNESS
	else:
		weakness = val

func damage(attack : Attack):
	if locked == true:
		#can put in a resource / class that can be changed / created as I wish
		return
	
	
	health -= attack.attack_damage
	set_weakness(weakness + attack.weakness_damage)
	
	hit.emit(attack)
	
	if attack.isGrabAttack:
		grabbed.emit(attack)
	
	if health <= 0:
		death.emit(attack)
	
	
func setHealthLock(lock : bool):
	locked = lock

func isHealthLocked():
	return locked
