extends SubViewport
class_name LittleSceneTransitioner

@export var fadeAnimator : AnimationPlayer

var pathAndScene : Dictionary = {}
var paths : Array[String] = []

signal onFadeInStart

var fps := 10.0

var t = 0.0
func _process(delta: float) -> void:
	###############################################################
	# PLACEHOLDER VALUES, ALLOW PLAYER TO SET VALUES IN SETTINGS  #
	###############################################################
	if Game.inLittleGame:
		fps = 60.0
	else:
		fps = 10.0
	
	t += delta
	var frame : float = 1.0 / fps
	if t >= frame:
		render_target_update_mode = SubViewport.UPDATE_ONCE
		t -= frame

func _ready() -> void:
	var startingScene : StartingLevelResourceScript = load("uid://byhqpp6gc4xnd")
	Game.littleViewport = self
	
	var s = SceneSwitchData.new()
	s.scene = startingScene.levelPath
	
	sceneData = s
	onFadeInComplete()
	

signal onSceneExit
var curScene : Node2D

var sceneData : SceneSwitchData
func switchScene(sd : SceneSwitchData) -> void:
	self.sceneData = sd
	fadeAnimator.play("FadeIn")
	onFadeInStart.emit()
	
func onFadeInComplete():
	#for t in threads:
		#if t.is_started():
			#t.wait_to_finish()
	#threads.clear()
	#paths = []
	
	onSceneExit.emit(sceneData)
	Game.onLevelSwitch.emit(sceneData)
	if curScene:
		curScene.queue_free()
	
	var s
	#if pathAndScene.has(sceneData.scene):
		#s = pathAndScene[sceneData.scene]
	#else:
		#s = load(sceneData.scene)
	s = load(sceneData.scene)
	
	#addSceneMutex.lock()
	#pathAndScene.clear()
	#addSceneMutex.unlock()
	
	var i : GenericLevel = s.instantiate()
	curScene = i
	add_child(i)
	Game.littleLevel = i
	i.initializeLevel(sceneData)
	
	fadeAnimator.play("FadeOut")

#var threads : Array[Thread] = []
#var addSceneMutex : Mutex = Mutex.new()

#func threadLoadScene(path : String):
	#if paths.has(path):
		#return
	#var t : Thread = Thread.new()
	#threads.append(t)
	#
	#t.start(loadScene.bind(path))

func loadScene(_path : String):
	pass
	#Hopefully freeze is fixed
	#var s = load(path)
	
	#addSceneMutex.lock()
	#pathAndScene[path] = s
	#addSceneMutex.unlock()

#func _exit_tree():
	#for t in threads:
		#t.wait_to_finish()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FadeIn":
		onFadeInComplete()
