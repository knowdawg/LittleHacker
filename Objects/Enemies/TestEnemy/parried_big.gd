extends GenericParriedState


# Called when the node enters the scene tree for the first time.
func customEnter(_prevState):
	if Game.player:
		var offset : Vector2 = Vector2(5, 0)
		if movement.direction == 1:
			offset *= -1
		movement.setPosition(Game.player.global_position + offset)
