extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	#material.set_shader_parameter("progress", 1.0)

func hitEfect(attack : Attack):
	$OmniDirectionalKnockbackComponent.calculateKnockback(attack)

func hitFromDirection(_attack : Attack, knockBack : Vector2):
	$AnimationPlayer.play("BloodSplatter")
	rotation = knockBack.angle()# + PI
