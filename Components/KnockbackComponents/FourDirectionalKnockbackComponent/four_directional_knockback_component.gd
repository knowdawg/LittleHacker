extends Node2D
class_name FourDirectionalKnockbackComponent

@export var parent : Node

func calculateKnockback(attack : Attack):
	var kbVec = Vector2.ZERO
	if attack.knockback_vector == Vector2.ZERO:
		kbVec = (attack.attack_position - global_position).normalized()
	else:
		kbVec = attack.knockback_vector
		kbVec *= -1
	
	var disRight = kbVec.distance_to(Vector2.RIGHT)
	var disLeft = kbVec.distance_to(Vector2.LEFT)
	var disUp = kbVec.distance_to(Vector2.UP)
	var disDown = kbVec.distance_to(Vector2.DOWN)
	
	var minDis = min(disRight, disLeft, disUp, disDown)
	
	if minDis == disRight:
		if parent.has_method("hitFromRight"):
			parent.hitFromRight(attack)
		else:
			printerr("Parent Does Not Have Required Functions To Utilize Four Directional Knockback")

	if minDis == disLeft:
		if parent.has_method("hitFromLeft"):
			parent.hitFromLeft(attack)
		else:
			printerr("Parent Does Not Have Required Functions To Utilize Four Directional Knockback")
	
	if minDis == disUp:
		if parent.has_method("hitFromUp"):
			parent.hitFromUp(attack)
		else:
			printerr("Parent Does Not Have Required Functions To Utilize Four Directional Knockback")
	
	if minDis == disDown:
		if parent.has_method("hitFromDown"):
			parent.hitFromDown(attack)
		else:
			printerr("Parent Does Not Have Required Functions To Utilize Four Directional Knockback")
	
