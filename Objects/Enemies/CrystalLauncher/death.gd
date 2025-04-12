extends State

@export var parent : CrystalLauncher
@export var animator : AnimationPlayer
@export var movement : MovementComponent
@export var spikeSprite : Sprite2D

func _ready() -> void:
	%HealthComponent.death.connect(onDeath)
	

func onDeath(attack : Attack):
	if attack.knockback_vector != Vector2.ZERO:
		var dir : Vector2 = %OmniDirectionalKnockbackComponent.returnVec(attack)
		%MovementComponent.applyForce(dir + Vector2(0.0, -1.0), 30.0)

func enter(_prevState):
	spikeSprite.visible = false
	animator.play("Death")
	movement.gravity = 10.0
	t = 0.0
	%HurtboxComponent.call_deferred("disable")

var t : float = 0.0
var landed = false
func update_physics(delta):
	t += delta
	if !landed and t >= 0.2 and %Down.is_colliding() and animator.current_animation != "DeathLand":
		animator.play("DeathLand")
		landed = true
