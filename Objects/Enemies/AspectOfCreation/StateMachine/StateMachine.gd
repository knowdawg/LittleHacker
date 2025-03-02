extends StateMachine
class_name AspectOfCreationStateMachine

@export_group("Ray Casts")
@export var leftBoundry : RayCast2D
@export var rightBoundry : RayCast2D

enum DIRECTION {LEFT, RIGHT}

var chanceToSlideAttack : float = 0.3

var vecToPlayer : Vector2
var distToPlayer : float
var dirToPlayer : DIRECTION
func custumProcess(_delta):
	if Game.player:
		vecToPlayer = (parent.global_position - Game.player.global_position)
		distToPlayer = abs(vecToPlayer.x)
		
		if vecToPlayer.x < 0:
			dirToPlayer = DIRECTION.RIGHT
		else:
			dirToPlayer = DIRECTION.LEFT

func isLeftBoundryColliding():
	return leftBoundry.is_colliding()

func isRightBoundryColliding():
	return rightBoundry.is_colliding()

func isNearBoundry():
	return leftBoundry.is_colliding() or rightBoundry.is_colliding()
