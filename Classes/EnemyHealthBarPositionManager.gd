extends Node2D

var healthbars : Array[EnemyHealthBar] = []

func getActualGlobalMousePosition():
	var mp = get_global_mouse_position()
	if is_instance_valid(Game.player):
		mp += Game.player.global_position
	mp *= 0.25
	return mp

var comparePos = Vector2.ZERO
func getClossestEnemyHealthBar(fromPos : Vector2):
	if healthbars.size() > 0:
		comparePos = fromPos * 4.0
		healthbars.sort_custom(custSort)
		return healthbars[0]
	else:
		return null

func custSort(a : EnemyHealthBar, b : EnemyHealthBar):
	var disA = a.follow.global_position.distance_to(comparePos)
	var disB = b.follow.global_position.distance_to(comparePos)
	if disA < disB:
		return true
	else:
		return false
