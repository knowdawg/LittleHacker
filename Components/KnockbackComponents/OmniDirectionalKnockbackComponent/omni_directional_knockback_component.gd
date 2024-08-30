extends Node2D
class_name OmniDirectionalKnockbackComponent

@export var parent : Node

func calculateKnockback(attack : Attack):
	var kbVec = Vector2.ZERO
	if attack.knockback_vector == Vector2.ZERO:
		kbVec = (attack.attack_position - global_position).normalized()
	else:
		kbVec = attack.knockback_vector
	
	if parent.has_method("hitFromDirection"):
		parent.hitFromDirection(attack, kbVec)
	else:
		printerr("Parent Does Not Have Required Functions To Utilize Omni Directional Knockback")
