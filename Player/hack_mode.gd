extends State
class_name PlayerHackMode

@export var animator : AnimationPlayer
@export var scaleAnimator : AnimationPlayer
@export var hackUI : SmallPLayerHackUI
@export var player : Player
@export var hackEffects : Node2D
@export var hurtboxComponent : HurtboxComponent

@export var rollSpeedCurve : Curve
@export var rollSpeedMultiplier : float = 6000

@export var detectionBox : Area2D
var viableTargets : Array[Area2D] = []

func _ready() -> void:
	Game.exitHackMode.connect(exitHackMode)
	hackUI.connect("executeHack", hackExecuted)

func hackExecuted():
	exitHackMode(true)

func exitHackMode(succesfull : bool = false):
	if isCurrentState:
		if succesfull:
			trasitioned.emit(self, "Idle")
		else:
			Game.setTimeScale(1.0)
			trasitioned.emit(self, "Blocked")

var isCurrentState = false
func enter(_prevState):
	t = 0.0
	hackEffects.startEffects()
	isCurrentState = true
	player.v = Vector2.ZERO
	animator.play("HackMode")
	scaleAnimator.play("HackMode")
	
	viableTargets.clear()
	#get targets to switch between
	curTargetIndex = 0
	for v : HurtboxComponent in detectionBox.get_overlapping_areas():
		if v.stateMachine:
			viableTargets.append(v)
	
	viableTargets.sort_custom(sortTargets)

func sortTargets(a : HurtboxComponent, b : HurtboxComponent):
	var dis1 : float = (player.global_position - a.global_position).length()
	var dis2 : float = (player.global_position - b.global_position).length()
	
	return dis1 < dis2

var t = 0.0
func update_physics(delta):
	player.update_physics(delta, false, false)
	t += delta;
	var progress : float = t / 0.2
	var speed : float = rollSpeedCurve.sample(progress) * rollSpeedMultiplier * delta
	if player.getSpriteDirection() == 1:
		speed *= -1
	player.dashV.x = -speed

var curTargetIndex = 0
func update(_delta):
	if Input.is_action_just_pressed("Parry"):
		if viableTargets.size() <= 1:
			return
		viableTargets[curTargetIndex].stateMachine.exitHackMode()
		curTargetIndex += 1
		if curTargetIndex >= viableTargets.size():
			curTargetIndex -= viableTargets.size()
		viableTargets[curTargetIndex].stateMachine.enterHackMode()
		hackUI.animate()
		$GlitchSwap.stop()
		$GlitchSwap.play("GlitchSwap")
		
	if hurtboxComponent.parryForgivenesTimer.time_left > 0:
		hurtboxComponent.damageStuff()

func exit(_nextState):
	hackEffects.endEffects()
	isCurrentState = false
	Game.setHackMode(false)
	player.dashV = Vector2.ZERO
	
