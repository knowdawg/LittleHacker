extends Node2D
class_name BiDirectionalKnockbackComponent

@export var parent : Node

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
	
	if disLeft == disRight: #if they are the same, pick a random one
		var r = randi_range(0, 1)
		if r == 0:
			disLeft += 0.1
			minDis = disLeft
		else:
			disRight += 0.1
			minDis = disRight
	
	if minDis == disRight:
		if parent.has_method("hitFromRight"):
			parent.hitFromRight(attack)
		else:
			printerr("Parent Does Not Have Required Functions To Utilize Bi Directional Knockback")

	if minDis == disLeft:
		if parent.has_method("hitFromLeft"):
			parent.hitFromLeft(attack)
		else:
			printerr("Parent Does Not Have Required Functions To Utilize Bi Directional Knockback")
