extends Sprite2D

#@export var impactFrame : ScreenEffects

func hitEfect(_attack : Attack):
	#impactFrame.impactFrame()
	$AnimationPlayer.play("RESET")
	
	#$AnimationPlayer.play("Animate")
