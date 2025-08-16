extends Line2D


@export var angleOffset : float = 0.0
@export var speedScale : float = 1.0

@export_group("TriggerOnHit")
@export var healthComponent : HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.speed_scale = speedScale
	$AnimationPlayer.play("RESET")
	if healthComponent:
		healthComponent.hit.connect(hitEfect)

func hitEfect(attack : Attack):
	$OmniDirectionalKnockbackComponent.calculateKnockback(attack)

func hitFromDirection(_attack : Attack, knockBack : Vector2):
	$AnimationPlayer.stop()
	$AnimationPlayer.play("BloodSplatter")
	rotation = knockBack.angle() + angleOffset
