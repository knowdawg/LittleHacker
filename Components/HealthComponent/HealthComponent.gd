extends Node2D
class_name HealthComponent

@export var parrent : Node
@export var knockbackComponent : Node2D

@export var hitEfects : Array[Node2D] = []

@export var emitSignalOnDeath : bool = true

@export var MAX_HEALTH := 10.0
var health : float

@export var MAX_WEAKNESS := 20.0
var weakness : float = 0.0

@export var locked = false

signal death

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
		attack.attack_damage = 0.0
		pass
	
	health -= attack.attack_damage
	set_weakness(weakness + attack.weakness_damage)
	
	if hitEfects.size() > 0:
		for p in hitEfects:
			p.hitEfect(attack)
	
	if health <= 0:
		if emitSignalOnDeath:
			death.emit()
		if parrent.has_method("death"):
			parrent.death(attack)
		return
	
	if knockbackComponent:
		knockbackComponent.calculateKnockback(attack)
	else:
		if parrent.has_method("hit"):
			parrent.hit(attack)
	
func setHealthLock(lock : bool):
	locked = lock

func isHealthLocked():
	return locked
