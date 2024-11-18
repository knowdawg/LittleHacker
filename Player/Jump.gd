extends State
class_name SmallPlayerJump

@export var animated_player_sprite : AnimationPlayer
@export var player : Player
#@export var playerStateMachine : PlayerStateMachine

var t : float = 0.0
func update_physics(delta):
	t += delta
	if t >= 0.2:
		animated_player_sprite.play("Jump")
	
	if Input.is_action_just_released("Jump"):
		player.killJump()
	
	player.update_physics(delta, true, true)
	
	if player.velocity.y >= 0.0:
		trasitioned.emit(self, "Fall")
		return

func enter(_prevState):
	player.jump();
	#if !Input.is_action_pressed("Jump"):
		#player.killJump()
	animated_player_sprite.play("JumpStart")
	t = 0
