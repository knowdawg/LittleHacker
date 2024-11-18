extends GenericParriedState
class_name TeleportToPlayerOnParry

@export var offset : Vector2

# Called when the node enters the scene tree for the first time.
func customEnter(_prevState):
	movement.resetForces()
	if Game.player:
		if movement.direction == 1:
			offset *= -1
		movement.setPosition(Game.player.global_position + offset)
