extends State

@export var parent : CursorFollower
@export var sprite : Sprite2D

var target : EnemyHealthBar
func enter(_prevState):
	var gmp = EnemyHealthBarPositionManager.getActualGlobalMousePosition()
	var closestHealthBar : EnemyHealthBar = EnemyHealthBarPositionManager.getClossestEnemyHealthBar(gmp)
	
	if closestHealthBar:
		target = closestHealthBar
		target.activate()
		sprite.frame = 1

func update(_delta):
	if !EnemyHealthBarPositionManager.hasHealthbar(target):
		trasitioned.emit(self, "Free")
		return
	
	if !is_instance_valid(target):
		trasitioned.emit(self, "Free")
		return
	
	parent.position = target.follow.global_position
	
	if Input.is_action_just_pressed("SwitchBar"):
		target.nextBar()
	
	if Input.is_action_just_pressed("LockOn"):
		var gmp = EnemyHealthBarPositionManager.getActualGlobalMousePosition()
		var closestHealthBar : EnemyHealthBar = EnemyHealthBarPositionManager.getClossestEnemyHealthBar(gmp)
		if closestHealthBar:
			var dis = closestHealthBar.follow.global_position.distance_to(gmp)
			if dis < 25:
				trasitioned.emit(self, "Focused")
			else:
				trasitioned.emit(self, "Free")
		else:
			trasitioned.emit(self, "Free")

func exit(_newState):
	if is_instance_valid(target):
		target.deactivate()
	sprite.frame = 0
