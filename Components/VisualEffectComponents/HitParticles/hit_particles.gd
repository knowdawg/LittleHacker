extends GPUParticles2D

func hitEfect(_attack : Attack):
	restart()
	emitting = true
