extends State
class_name PlayerOnZipline

@export var spriteAnimator : AnimationPlayer
@export var playerStateMachine : PlayerStateMachine
@export var player : Player

func enter(_prevState):
	spriteAnimator.play("Stun")

func update_physics(_delta):
	if playerStateMachine.getInputBuffer() == "Jump":
		player.exitZipline()
		trasitioned.emit(self, "Jump")
		playerStateMachine.resetInputBuffer()
		return
