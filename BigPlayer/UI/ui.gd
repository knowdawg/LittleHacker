extends CanvasLayer

@export var staminaComponent : StaminaComponent

func _ready() -> void:
	%AnimatedSprite2D.play("HeartBeat")

func _process(_delta: float) -> void:
	%Stamina.value = staminaComponent.getStamina()
	%Health.value = staminaComponent.get_health()
