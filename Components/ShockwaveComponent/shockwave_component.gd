extends Sprite2D
class_name ShockwaveComponent

@export var animationSpeed : float = 1.0

func _ready() -> void:
	%AnimationPlayer.speed_scale = animationSpeed


func _process(delta: float) -> void:
	screemTimer -= delta
	if screemTimer <= 0.0:
		if %AnimationPlayer.current_animation == "Screem":
			reset()
			
	suckTimer -= delta
	if suckTimer <= 0.0:
		if %AnimationPlayer.current_animation == "Suck":
			reset()

func setSpeed(val : float):
	%AnimationPlayer.speed_scale = val

func shockwave():
	%AnimationPlayer.stop()
	%AnimationPlayer.play("Shockwave")

var screemTimer = 0.0
func screem(duration : float):
	screemTimer = duration
	%AnimationPlayer.stop()
	%AnimationPlayer.play("Screem")

var suckTimer = 0.0
func suck(duration : float):
	suckTimer = duration
	%AnimationPlayer.stop()
	%AnimationPlayer.play("Suck")

func reset():
	%AnimationPlayer.stop()
	%AnimationPlayer.play("RESET")
