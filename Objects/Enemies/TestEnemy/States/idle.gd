extends State
class_name StationaryIdle

@export_group("Next States")
@export var agroState : State

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var playerProximity : ProximityAreaComponent

func enter():
	animator.play("Idle")

func update(_delta):
	if playerProximity.is_player_inside():
		trasitioned.emit(self, agroState.name)
