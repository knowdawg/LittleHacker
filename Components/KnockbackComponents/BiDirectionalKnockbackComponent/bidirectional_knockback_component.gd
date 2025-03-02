extends Node2D
class_name BiDirectionalKnockbackComponent

@export var parent : Node
@export var movement : MovementComponent

@export var dirLeft : Vector2 = Vector2.ZERO
@export var dirRight : Vector2 = Vector2.ZERO

func calculateKnockback(attack : Attack):
	var kbVec = Vector2.ZERO
	if attack.knockback_vector == Vector2.ZERO:
		kbVec = (attack.attack_position - global_position).normalized()
	else:
		kbVec = attack.knockback_vector
		kbVec *= -1
	
	var disLeft = kbVec.distance_to(dirLeft)
	var disRight = kbVec.distance_to(dirRight)
	
	var minDis = min(disLeft, disRight)
	
	if disLeft == disRight: #if they are the same
		kbVec = (attack.attack_position - global_position).normalized()
		
		disLeft = kbVec.distance_to(dirLeft)
		disRight = kbVec.distance_to(dirRight)
		minDis = min(disLeft, disRight)
	
	if minDis == disRight:
		if parent.has_method("hitFromRight"):
			parent.hitFromRight(attack)
		elif movement:
			movement.applyForce(dirLeft, attack.knockback_force)
		else:
			printerr("Parent Does Not Have Required Functions To Utilize Bi Directional Knockback")

	if minDis == disLeft:
		if parent.has_method("hitFromLeft"):
			parent.hitFromLeft(attack)
		elif movement:
			movement.applyForce(dirRight, attack.knockback_force)
		else:
			printerr("Parent Does Not Have Required Functions To Utilize Bi Directional Knockback")

func returnVecFromTwoObjects(obj1, obj2):
	var vec : Vector2 = obj1.global_position - obj2.global_position
	vec = vec.normalized()
	
	var disLeft = vec.distance_to(dirLeft)
	var disRight = vec.distance_to(dirRight)
	
	if disLeft < disRight:
		return dirLeft
	else:
		return dirRight
