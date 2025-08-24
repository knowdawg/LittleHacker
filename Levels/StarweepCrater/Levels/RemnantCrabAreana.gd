extends GenericLevel
class_name RemnantCrabArena

@export var remnantCrab : RemnantCrab
@export var landParticles : GPUParticles2D
@export var smallImpactParticles : GPUParticles2D

func customReady():
	remnantCrab.landed.connect(remnantCrabLand)
	remnantCrab.impact.connect(remnantCrabSmallImpact)

func remnantCrabLand():
	landParticles.restart()
	landParticles.emitting = true
	
	randomizeFireStoke(0.0)

func remnantCrabSmallImpact():
	smallImpactParticles.restart()
	smallImpactParticles.emitting = true
	
	randomizeFireStoke(-5.0)

func randomizeFireStoke(volume : float = 0.0):
	%FireStoke.volume_db = volume
	%FireStoke.pitch_scale = randf_range(0.9, 1.1)
	%FireStoke.play()
