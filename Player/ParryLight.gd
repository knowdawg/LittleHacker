extends PointLight2D

func hitEfect(attack : Attack):
	var angle : Vector2 = $OmniDirectionalKnockbackComponent.returnVec(attack)
	$GPUParticles2D.restart()
	$GPUParticles2D2.restart()
	$GPUParticles2D.rotation = angle.angle()
	$GPUParticles2D2.rotation = angle.angle() + PI
	$Flare.rotation = angle.angle() + (PI / 12.0)
	$AnimationPlayer.play("Flash")
