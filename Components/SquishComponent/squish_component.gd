extends Node
class_name SquishComponent

@export var squishTarget : Node2D
@export var squishAmount : float = 0.5
@export var squishSpeed : float = 0.05

@export_group("SquishOnHit")
@export var healthComponent : HealthComponent

func squish():
	var t : Tween = create_tween()
	t.tween_property(squishTarget, "scale", Vector2(1.0 - squishAmount, 1.0 + squishAmount), squishSpeed)
	t.tween_property(squishTarget, "scale", Vector2(1.0 + squishAmount, 1.0 - squishAmount), squishSpeed)
	t.tween_property(squishTarget, "scale", Vector2(1.0, 1.0), squishSpeed)


func onHealthComponentHit(_a):
	squish()
func _ready() -> void:
	if healthComponent:
		healthComponent.hit.connect(onHealthComponentHit)
