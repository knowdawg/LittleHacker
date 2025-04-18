extends State
class_name SmallPlayerIdle

@export var animator : AnimationPlayer
@export var player : Player
@export var playerStateMachine : PlayerStateMachine

func update_physics(delta):
	player.update_physics(delta, true, true)
	
	if playerStateMachine.getInputBuffer() == "Jump":
		trasitioned.emit(self, "Jump")
		playerStateMachine.resetInputBuffer()
		return
	if abs(player.velocity.x) > 5.0:
		trasitioned.emit(self, "Run")
		return
	if player.velocity.y > 0.0:
		trasitioned.emit(self, "Fall")
		return
	if playerStateMachine.getInputBuffer() == "Roll":
		trasitioned.emit(self, "Roll")
		playerStateMachine.resetInputBuffer()
		return

func enter(prevState):#if you are slightly off ground you imidialty go int of fall state and skip animation
	if prevState is PlayerHackMode:
		animator.play("ExecuteParry")
	else:
		animator.play("Idle")
