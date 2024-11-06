extends State
class_name PlayerHackMode

@export var animator : AnimationPlayer
@export var scaleAnimator : AnimationPlayer
@export var player : Player
@export var hackEffects : Node2D

@export var rollSpeedCurve : Curve
@export var rollSpeedMultiplier : float = 6000

func _ready() -> void:
	Game.exitHackMode.connect(exitHackMode)

func exitHackMode():
	if isCurrentState:
		trasitioned.emit(self, "Idle")

var isCurrentState = false
func enter(_prevState):
	t = 0.0
	hackEffects.startEffects()
	isCurrentState = true
	player.v = Vector2.ZERO
	animator.play("HackMode")
	scaleAnimator.play("HackMode")

var t = 0.0
func update_physics(delta):
	player.update_physics(delta, false, false)
	t += delta;
	var progress : float = t / 0.2
	var speed : float = rollSpeedCurve.sample(progress) * rollSpeedMultiplier * delta
	if player.getSpriteDirection() == 1:
		speed *= -1
	player.dashV.x = -speed

func update(_delta):
	if Input.is_action_just_pressed("Jump"):
		Game.setHackMode(false)

func exit(_nextState):
	hackEffects.endEffects()
	isCurrentState = false
	Game.setHackMode(false)
	player.dashV = Vector2.ZERO
