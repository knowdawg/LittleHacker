extends State
class_name SmallPlayerRun

@export var animator : AnimationPlayer
@export var player : Player
@export var playerStateMachine : PlayerStateMachine
@export var audios : Array[AudioStreamPlayer] = []

func update_physics(delta):
	player.update_physics(delta, true, true)
	
	if playerStateMachine.getInputBuffer() == "Jump":
		trasitioned.emit(self, "Jump")
		playerStateMachine.resetInputBuffer()
		return
	if abs(player.velocity.x) < 5.0:
		trasitioned.emit(self, "Idle")
		return
	if player.velocity.y > 0.0:
		trasitioned.emit(self, "Fall")
		return
	if playerStateMachine.getInputBuffer() == "Roll":
		trasitioned.emit(self, "Roll")
		playerStateMachine.resetInputBuffer()
		return

func enter(_prevState):
	animator.play("Run")

func makeSound():
	var i : int = randi_range(0, audios.size() -1)
	audios[i].pitch_scale = 1.0 + randf_range(-0.1, 0.1)
	audios[i].play()
