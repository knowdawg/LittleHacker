extends GenericTransitionState
class_name PlayerGrappleAttack

@export var player : Player


func customEnter(_prevState):
	player.grappleBoost = Vector2(1.3, -1.0) * 50.0
	player.grappleBoost.x *= -player.getSpriteDirection()

func update_physics(delta):
	player.update_physics(delta, true, false)
	if player.is_on_floor():
		player.grappleBoost.y = 0.0

func beforeTransition():
	player.v.y += player.grappleBoost.y
	player.grappleBoost.y = 0.0
