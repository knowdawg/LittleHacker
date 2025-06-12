extends Node2D
class_name OmniDirectionalKnockbackComponent

@export var parent : Node
@export var movement : MovementComponent
@export var knockbackMultiplier : float = 1.0

func calculateKnockback(attack : Attack):
	var kbVec = Vector2.ZERO
	if attack.knockback_vector == Vector2.ZERO:
		kbVec = (attack.attack_position - global_position).normalized()
	else:
		kbVec = attack.knockback_vector
	
	
	if parent.has_method("hitFromDirection"):
		parent.hitFromDirection(attack, kbVec)
	else:
		movement.applyForce(kbVec, attack.knockback_force * knockbackMultiplier)


func returnVec(attack : Attack):
	var kbVec = Vector2.ZERO
	if attack.knockback_vector == Vector2.ZERO:
		kbVec = (attack.attack_position - global_position).normalized()
	else:
		kbVec = attack.knockback_vector
		
	return kbVec

func returnVecFromTwoObjects(obj1 : Node2D, obj2 : Node2D):
	var vec = obj1.global_position - obj2.global_position
	return vec.normalized()

func returnVecFromTwoVectors(vec1 : Vector2, vec2 : Vector2):
	var vec = vec1 - vec2
	return vec.normalized()
