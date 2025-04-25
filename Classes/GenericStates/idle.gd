extends State
class_name StationaryIdle

@export_group("Next States")
@export var agroStates : Array[State] = []

@export_group("Necesary Nodes")
@export var animator : AnimationPlayer
@export var animationName : String
@export var playerProximity : ProximityAreaComponent

func enter(_prevState):
	animator.play(animationName)

func update(_delta):
	if playerProximity:
		if playerProximity.is_player_inside():
			var r = randi_range(0, agroStates.size() - 1)
			trasitioned.emit(self, agroStates[r].name)
