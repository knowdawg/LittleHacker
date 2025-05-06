@tool
extends Node2D
class_name GenericFoliage

@export var hurtbox : HurtboxComponent
@export var healthComponent : HealthComponent
@export var animator : AnimationPlayer
@export var idleAnimatorName : String
@export var deathAnimationName : String

func _ready() -> void:
	if !Engine.is_editor_hint():
		if healthComponent:
			healthComponent.hit.connect(hit)
		if animator:
			animator.speed_scale = randf_range(0.9, 1.1)
			animator.play(idleAnimatorName)

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if animator:
			animator.play(idleAnimatorName)

func hit(_a):
	if animator:
		animator.play(deathAnimationName)
	if hurtbox:
		hurtbox.call_deferred("disable")
