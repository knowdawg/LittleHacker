extends ProgressBar

@export var healthComponent : HealthComponent

func _process(_delta: float) -> void:
	var percentage : float = 100.0 * healthComponent.health / healthComponent.MAX_HEALTH
	
	#print(percentage)
	#print(healthComponent.health)
	
	value = percentage
