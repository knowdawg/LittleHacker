extends GPUParticles2D

@export var omniDirectional : bool = true

@export_group("TriggerOnHit")
@export var healthComponent : HealthComponent

func _ready() -> void:
	if healthComponent:
		healthComponent.hit.connect(hitEfect)

func hitEfect(attack : Attack):
	restart()
	if omniDirectional:
		$OmniDirectionalKnockbackComponent.calculateKnockback(attack)
	else:
		$FourDirectionalKnockbackComponent.calculateKnockback(attack)

func hitFromLeft(_attack : Attack):
	rotation_degrees = 0.0
	emitting = true

func hitFromRight(_attack : Attack):
	rotation_degrees = 180.0
	emitting = true

func hitFromUp(_attack : Attack):
	rotation_degrees = 90.0
	emitting = true

func hitFromDown(_attack : Attack):
	rotation_degrees = 270.0
	emitting = true

func hitFromDirection(_attack : Attack, knockBack : Vector2):
	rotation = knockBack.angle()# + PI
	emitting = true
