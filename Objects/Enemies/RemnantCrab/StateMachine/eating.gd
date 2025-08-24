extends State
class_name RemnantCrabEating

@export var eatingArms: Sprite2D
@export var sm : RemnantCrabStateMachine
@export var interuptedSound : RandomPitchAudio

@export_group("Next States")
@export var agroState : State

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var animationName : String
@export var playerProximity : ProximityAreaComponent

func enter(_prevState):
	animator.play(animationName)
	playerHasEntered = false

var playerHasEntered : bool = false
func update(_delta):
	if playerProximity:
		if playerProximity.is_player_inside() and !playerHasEntered:
			playerHasEntered = true
			interuptedSound.playSound()
			animator.play("Suprised")


func _on_health_component_hit(_attack: Attack) -> void:
	if sm.current_state is RemnantCrabEating:
		trasitioned.emit(self, agroState.name)

func exit(_n):
	eatingArms.visible = false
