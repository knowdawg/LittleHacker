extends State
class_name BigPlayerRun

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

@export var sprite : Sprite2D

var t := 0.0
func enter(_p : State):
	animator.speed_scale = 1.5
	t = 0.0
	animator.play("StartOfRun")

func update_physics(delta: float) -> void:
	parent.fall(delta)
	parent.check_for_movement_run(delta)

var prevSpriteDir : bool = true
func update(delta):
	parent.updateSpriteDirection()
	
	if prevSpriteDir != sprite.flip_h:
		prevSpriteDir = sprite.flip_h
		animator.play("StartOfRun")
		if t > 0.26:
			t = 0.0
	
	t += delta
	if t >= (0.26):
		animator.play("Run")
		
		if !Input.is_action_pressed("Roll"):
			trasitioned.emit(self, "Walk")
			return
	
		if abs(parent.runMovement.x) < 0.1:
			trasitioned.emit(self, "Idle")
			return
	
	if parent.getSummedVelocities().y > 0:
		trasitioned.emit(self, "Fall")
		return
	
	if stateMachine.getInputBuffer() == "Block":
		trasitioned.emit(self, "Block")
		return
	
	if stateMachine.getInputBuffer() == "Jump":
		trasitioned.emit(self, "Jump")
		return
	
	if stateMachine.getInputBuffer() == "Attack":
		trasitioned.emit(self, "AttackCharge")
		return

func exit(_n):
	animator.speed_scale = 1.0
