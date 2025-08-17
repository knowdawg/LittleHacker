extends GPUParticles2D

@export_group("TriggerOnHit")
@export var healthComponent : HealthComponent

func _ready() -> void:
	if healthComponent:
		healthComponent.hit.connect(hitEfect)

func hitEfect(_attack : Attack):
	restart()
	emitting = true
