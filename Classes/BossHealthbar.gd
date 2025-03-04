extends CanvasLayer

@export var healthComponent : HealthComponent
@export var healthBar : TextureProgressBar
@export var weaknessBar : TextureProgressBar

@export var animator : AnimationPlayer

func _process(delta: float) -> void:
	var healthPercentage : float = healthComponent.get_health() / healthComponent.get_max_health()
	healthPercentage *= 100.0
	
	var weaknessPercentage : float = healthComponent.get_weakness() / healthComponent.get_max_weakness()
	weaknessPercentage *= 100.0
	
	healthBar.value = move_toward(healthBar.value, healthPercentage, delta * 60.0)
	weaknessBar.value = weaknessPercentage
