extends StateMachine
class_name AspectOfCreationStateMachine

enum DIRECTION {LEFT, RIGHT}

var chanceToSlideAttack : float = 0.3

var vecToPlayer : Vector2
var distToPlayer : float
var dirToPlayer : DIRECTION
func custumProcess(delta):
	vecToPlayer = (parent.global_position - Game.player.global_position)
	distToPlayer = abs(vecToPlayer.x)
	
	if vecToPlayer.x < 0:
		dirToPlayer = DIRECTION.RIGHT
	else:
		dirToPlayer = DIRECTION.LEFT
