extends State
class_name SmallPlayerFall

@export var animated_player_sprite : AnimationPlayer
@export var animated_scale : AnimationPlayer
@export var player : Player
@export var playerStateMachine : PlayerStateMachine

func update_physics(delta):
	player.update_physics(delta, true, true)
	
	if player.velocity.y == 0.0:
		trasitioned.emit(self, "Idle")
		animated_scale.play("HitGround")
		return
	
	if playerStateMachine.inputBuffer == "Jump":
		if player.canCoyoteJump() == true:
			trasitioned.emit(self, "Jump")
			return
			
	if player.is_on_wall():
		trasitioned.emit(self, "WallCling")
		return

func enter(_prevState):
	animated_player_sprite.play("Fall")
