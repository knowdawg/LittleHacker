extends State
class_name PlayerGroundParry

@export var animated_player_sprite : AnimationPlayer
@export var player : Player
@export var sm : PlayerStateMachine

func enter(_prevState):
	t = 0.4
	animated_player_sprite.play("GroundParry")
	player.v.x = 0.0

var t = 0.4
func update(delta):
	t -= delta
	
	if sm.getInputBuffer() == "Roll":
		trasitioned.emit(self, "Roll")
		return
	
	if t <= 0.2:
		if abs(Input.get_axis("Left", "Right")) > 0.1:
			trasitioned.emit(self, "Idle")
		
	if t <= 0.0:
		trasitioned.emit(self, "Idle")

func update_physics(delta):
	player.update_physics(delta, true, true)
