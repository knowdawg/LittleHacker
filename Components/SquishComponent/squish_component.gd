extends Node
class_name SquishComponent

@export var squishTarget : Node2D

@export_group("SquishOnHit")
@export var healthComponent : HealthComponent

func squish():
	var t : Tween = create_tween()
	t.tween_property(squishTarget, "scale", Vector2(0.5, 1.5), 0.05)
	t.tween_property(squishTarget, "scale", Vector2(1.5, 0.5), 0.05)
	t.tween_property(squishTarget, "scale", Vector2(1.0, 1.0), 0.05)


func onHealthComponentHit(_a):
	squish()
func _ready() -> void:
	if healthComponent:
		healthComponent.hit.connect(onHealthComponentHit)
