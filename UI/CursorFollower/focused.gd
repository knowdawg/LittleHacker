extends State

@export var parent : CursorFollower

var target : EnemyHealthBar
func enter(_prevState):
	var gmp = EnemyHealthBarPositionManager.getActualGlobalMousePosition()
	var closestHealthBar : EnemyHealthBar = EnemyHealthBarPositionManager.getClossestEnemyHealthBar(gmp)
	
	if closestHealthBar:
		target = closestHealthBar

func update(delta):
	if !is_instance_valid(target):
		return
	parent.position = lerp(parent.position, target.follow.global_position, delta * 30.0)
	
	var gmp = EnemyHealthBarPositionManager.getActualGlobalMousePosition()
	var dis = target.follow.global_position.distance_to(gmp)
	
	var closestHealthBar : EnemyHealthBar = EnemyHealthBarPositionManager.getClossestEnemyHealthBar(gmp)
	if closestHealthBar != target:
		target = closestHealthBar
	
	parent.rotation += delta * 5.0
	
	if dis > 25:
		trasitioned.emit(self, "Free")
	elif Input.is_action_just_pressed("LockOn"):
		trasitioned.emit(self, "Locked")

func exit(_newState):
	parent.rotation = 0.0
