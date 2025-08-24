@tool extends Node2D
class_name GenericLevel

#StartingLevelResourceScript must be open for this to work
@export_tool_button("Set as Starting Level", "Callable") var set_level_action = setSelfAsStartingLevel
func setSelfAsStartingLevel():
	var startSceneResource : StartingLevelResourceScript = load("uid://byhqpp6gc4xnd")
	startSceneResource.levelPath = self.scene_file_path
	
	print("Starting scene set as : " + self.scene_file_path)

@export var projectileSpawnNode : Node2D
@export var enemySpawnLocation : Node2D

@export_group("PlayerSpawnDetails")
@export var doorToSpawnPlayerOnFailure : LevelTransition
@export var doorContainerNode : Node2D
@onready var doors = doorContainerNode.get_children()
@export var whereToAddPlayer : Node2D

@export_group("PlayerRespawnDetails")
@export var respawnPointNode : Node2D
@onready var respawnPoints = respawnPointNode.get_children()


@export_group("Lighting")
@export var lighting : ColorRect
@export var lightingBrightness : float = 1.0
@export var backgroundGradient : GradientTexture2D
@export_subgroup("WorldEnvironment")
@export var environment : Environment

@export_group("Audio")
@export var ambiences : Array[AudioStreamPlayer]
@export var reverb : AudioEffectReverb

func _ready() -> void:
	Game.enterLittleGame.connect(setEnvirement)
	if reverb:
		var busIndex : int = AudioServer.get_bus_index("SoundEffects")
		#Clear Existing effects
		for i in range(AudioServer.get_bus_effect_count(busIndex)):
			AudioServer.remove_bus_effect(busIndex, 0)
		#Add This room's effects
		AudioServer.add_bus_effect(busIndex, reverb)
	
	for a in ambiences:
		a.play()
	
	customReady()

func customReady():
	pass

#Called by SceneTransitionManager When the level is ready
func initializeLevel(sceneData : SceneSwitchData) -> void:
	if lighting:
			lighting.material.set_shader_parameter("brightness", lightingBrightness)
	
	if !sceneData.respawnPlayer:
		var p = Game.createPlayer()
		p.initialize(sceneData)
		whereToAddPlayer.add_child(p)
		var d : LevelTransition
		for i in doors:
			if !sceneData.doorName:
				break
			if sceneData.doorName.to_lower() == i.name.to_lower():
				d = i
				break
		if d == null:
			d = doorToSpawnPlayerOnFailure
		p.position = d.enterPosition.global_position
	else:
		var r : RespawnPoint
		var respawnPointName : String = sceneData.respawnData.respawnPointName
		for i in respawnPoints:
			if i.respawnPointName == respawnPointName:
				r = i
				break
		if r == null:
			var p = Game.createPlayer()
			p.initialize(sceneData)
			whereToAddPlayer.add_child(p)
			p.position = doorToSpawnPlayerOnFailure.enterPosition.global_position
			return
		r.spawnPlayer(sceneData)

func setEnvirement():
	if environment:
		GameWorldEnvirement.setEnvironment(environment)
	else:
		GameWorldEnvirement.clearEnvironment()


func addProjectile(projectile):
	projectileSpawnNode.add_child(projectile)

func addEnemy(enemy):
	enemySpawnLocation.add_child(enemy)
