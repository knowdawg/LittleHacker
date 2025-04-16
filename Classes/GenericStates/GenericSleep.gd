extends State
class_name GenericSleep

@export var animator : AnimationPlayer
@export var sleepAnimationName : String = ""
@export var hurtboxes : Array[HurtboxComponent] = []

@export_group("Healthbar")
@export var showHealthbarOnWake : bool = true
@export var healthBar : EnemyHealthBar

func enter(_prevState):
	if healthBar:
		healthBar.showBars = false
	
	if animator:
		animator.play(sleepAnimationName)
	
	for h in hurtboxes:
		h.call_deferred("disable")

func exit(_nextState):
	for h in hurtboxes:
		h.call_deferred("enable")
	if healthBar and showHealthbarOnWake:
		healthBar.showBars = true
