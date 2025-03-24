extends Node2D

var healthbars : Array[EnemyHealthBar] = []

func addHealthbar(h : EnemyHealthBar):
	for he in healthbars:
		if he == h:
			return
	healthbars.append(h)

func removeHealbar(h : EnemyHealthBar):
	for i in healthbars.size():
		if healthbars[i] == h:
			healthbars.remove_at(i)
			return

func hasHealthbar(h : EnemyHealthBar) -> bool:
	for he in healthbars:
		if he == h:
			return true
	return false

func getActualGlobalMousePosition():
	var mp = get_global_mouse_position()
	mp /= 10.0 #getResolutionRatio()
	if is_instance_valid(Game.player):
		mp += Game.player.global_position
	return mp

var comparePos = Vector2.ZERO
func getClossestEnemyHealthBar(fromPos : Vector2):
	if healthbars.size() > 0:
		comparePos = fromPos 
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

func clear():
	healthbars = []

func getResolutionRatio():
	return get_viewport_rect().size.y / 720.0

func levelSwiched(_sceneData : SceneSwitchData):
	clear()

func _process(_delta: float) -> void:
	if Game.littleViewport:
		var s = Game.littleViewport.onSceneExit
		if !s.is_connected(levelSwiched):
			s.connect(levelSwiched)
