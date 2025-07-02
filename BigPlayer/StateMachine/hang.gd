extends State
class_name BigPlayerHanging

@export var animator : AnimationPlayer
@export var parent : BigPlayer
@export var stateMachine : BigPlayerStateMachine

@export var ladderProx : ProximityAreaComponent

@export var topLadderProx : ProximityAreaComponent

var t = 0.0

func enter(_p):
	t = 0.0
	animator.play("Hang")
	
	snapToRung()
	
	topLadderProx.position.y = -5.0

func snapToRung():
	#parent.global_position.y = round(parent.global_position.y)
	if ladderProx.getAreas().size() > 0:
		parent.global_position.y = ladderProx.getAreas()[0].global_position.y + 17.0


func update(delta):
	t += delta
	
	if Input.is_action_pressed("Up"):
		trasitioned.emit(self, "Climbing")
		return
	
	if Input.is_action_just_pressed("Down"):
		trasitioned.emit(self, "Fall")
		return
	
	if stateMachine.inputBuffer == "Jump":
		trasitioned.emit(self, "Jump")
		return
	
	#if t >= 0.8:
		#trasitioned.emit(self, "Climbing")
		#return

func exit(n : State):
	if n is BigPlayerClimb:
		return
		
	parent.climbing = false
	parent.set_collision_mask_value(1, true)
	parent.set_collision_mask_value(2, true)
	topLadderProx.position.y = 0.0
	
	if n is BigPlayerJump:
		%PlayerSprite.frame = 56
		%SpriteDirectorComponent.flipXDir()
		return
	
	if n is BigPlayerFall:
		parent.position.x += parent.getDirection() * 4.0
		parent.position.y += 4.0
		%PlayerSprite.frame = 34
		%SpriteDirectorComponent.flipXDir()
	
