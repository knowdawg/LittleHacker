extends State

@export var parent : CursorFollower

func update(delta):
	var gmp = EnemyHealthBarPositionManager.getActualGlobalMousePosition()
	parent.position = lerp(parent.position, gmp - Vector2(-0.5, 1.5), delta * 30.0)
	
	var closestHealthBar : EnemyHealthBar = EnemyHealthBarPositionManager.getClossestEnemyHealthBar(gmp)
	if closestHealthBar:
		var dis = closestHealthBar.follow.global_position.distance_to(gmp)
		if dis < 20:
			trasitioned.emit(self, "Focused")
