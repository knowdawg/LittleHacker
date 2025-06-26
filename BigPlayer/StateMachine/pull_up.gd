extends State
class_name BigPlayerPullUp

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

var t := 0.0
func enter(p : State):
	parent.climbing = true
	parent.set_collision_mask_value(1, false)
	parent.set_collision_mask_value(2, false)
	
	t = 0.0
	animator.play("PullUp")

func update_physics(delta):
	t += delta
	
	if Input.is_action_pressed("Roll"):
		animator.speed_scale = 2.0
		t += delta
	else:
		animator.speed_scale = 1.0
	
	if t >= 1.2:
		trasitioned.emit(self, "Idle")
		return
	
	if stateMachine.inputBuffer == "Jump":
		trasitioned.emit(self, "Jump")
		return
	
	#if Input.is_action_pressed("Down"):
		#trasitioned.emit(self, "SlideDown")
		#return

func moveParrent(amount : float):
	parent.position.y -= amount

func exit(n : State):
	animator.speed_scale = 1.0
	if n is BigPlayerSlideDown:
		return
	parent.climbing = false
	parent.set_collision_mask_value(1, true)
	parent.set_collision_mask_value(2, true)
