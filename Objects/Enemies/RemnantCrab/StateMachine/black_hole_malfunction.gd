extends GenericTransitionState

@export var skulls : Sprite2D
@export var blackHole : Sprite2D
@export var parent : RemnantCrab
@export var healthCom : HealthComponent

func customEnter(_prevState):
	attackTimer = 0.0
	blackHole.global_position = skulls.global_position

var attackTimer : float = 0.0

func customUpdate(delta):
	if t>= 0.6 and t <= 2.2:
		parent.suckInPlayer(delta, 5.0)
		attackTimer += delta
		if attackTimer >= 0.1:
			attackTimer -= 0.1
			
			var a : Attack = Attack.new()
			a.attack_damage = 2.0
			a.knockback_vector = Vector2.from_angle(randf_range(-PI, PI))
			
			healthCom.damage(a)
