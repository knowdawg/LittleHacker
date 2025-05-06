extends StateMachine
class_name CrystalEliteStateMachine

var stamina : int = 5

enum DIRECTION {LEFT, RIGHT}

var vecToPlayer : Vector2
var distToPlayer : float
var dirToPlayer : DIRECTION
func custumProcess(_delta):
	if Game.doesPlayerExist():
		vecToPlayer = (parent.global_position - Game.player.global_position)
		distToPlayer = abs(vecToPlayer.x)
		
		if vecToPlayer.x < 0:
			dirToPlayer = DIRECTION.RIGHT
		else:
			dirToPlayer = DIRECTION.LEFT
