extends CharacterBody2D

#enum colorChoices {PURPLE = 0, RED = 1, GREEN = 2}
#@export var color : colorChoices

#@export_group("Sprite Sheets")
#@export var greenSprite : Resource
#@export var redSprite : Resource
#@export var greenSlam : Resource
#@export var redSlam : Resource
#@export var greenShater : Resource
#@export var redShater : Resource
@export var projectile : PackedScene
@export var buggy : PackedScene

var canResonate : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GeneralComponents/HealthComponent.hit.connect(checkResonanceHit)
	#if color == 0:
		#pass
	#elif color == 1:
		#$Sprite2D.texture = redSprite
		#$HeadShatter.texture = redShater
		#$AttackComponents/HeadSlam/CrystalExsplotionEffect.texture = redSlam
		#$PointLight2D.color = Color(0.15, 0, 0)
	#elif color == 2:
		#$Sprite2D.texture = greenSprite
		#$HeadShatter.texture = greenShater
		#$AttackComponents/HeadSlam/CrystalExsplotionEffect.texture = greenSlam
		#$PointLight2D.color = Color(0, 0.15, 0)

func checkResonanceHit(attack : Attack):
	if attack.attackName == "CrystalResonanceBlast":
		if canResonate:
			$ResonanceTimer.start()
			canResonate = false
			$ResonanceCooldownTimer.start()

func resonate():
	var p = projectile.instantiate()
	#p.color = color
	Game.addProjectile(p)
	p.position = global_position

func _on_resonance_timer_timeout() -> void:
	resonate()

func _on_resonance_cooldown_timer_timeout() -> void:
	canResonate = true


func _on_shatter_executed() -> void:
	for i in randi_range(1, 2):
		var b : HealthBuggy = buggy.instantiate()
		Game.addEnemy(b)
		b.position = global_position
		b.movement.applyForce(Vector2(randf_range(-0.3, 0.3), -1), 150)
