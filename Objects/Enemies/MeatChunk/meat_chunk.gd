extends Enemy
class_name MeatChunk

@export var forceCurve : Curve
@export var gravity : float = 10.0

var force : float = 10.0
var dir := Vector2(1.0, 1.0)

var healAmount : float = 0.5

func customReady():
	pass

var t = 0.0
var g : float = 0.0
func _physics_process(delta: float) -> void:
	t += delta
	
	g += gravity * delta
	if is_on_floor():
		g = 0.0
	
	
	velocity = dir * force * forceCurve.sample(t)
	velocity.y += g
	if is_on_floor():
		velocity.y = 0.0
		velocity.x *= 0.5
	
	move_and_slide()

var healOrb = preload("uid://d2j3fqxswjbe0")
func createHealOrb():
	var healOrb : HealOrbProjectile = healOrb.instantiate()
	healOrb.healAmount = healAmount
	
	Game.addProjectile(healOrb)
	healOrb.global_position = global_position
