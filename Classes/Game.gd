extends Node

#Little Level
var player : Player
var camera : SmallPlayerCamera
var littleLevel : GenericLevel
var littleViewport : LittleSceneTransitioner

########
var inLittleGame : bool = false
########

#Big Level
var bigPlayer : BigPlayer
var bigCamera : BigCamera

var respawnData : RespawnData

var platformingRespawnPos : Vector2 = Vector2.ZERO

var inHackMode = false
var hackedEnemy = null
var hackedHealthbar : EnemyHealthBar = null
signal enterHackMode
signal exitHackMode

signal onLevelSwitch(data : SceneSwitchData)

func slowTime(timeScale : float):
	Engine.time_scale = timeScale

func setTimeScale(timeScale : float):
	Engine.time_scale = timeScale

func _process(delta: float) -> void:
	if inHackMode:
		Engine.time_scale = move_toward(Engine.time_scale, 0.1, delta * 60.0)
	else:
		Engine.time_scale = move_toward(Engine.time_scale, 1.0, delta * 5.0)

func setHackMode(on : bool):
	if inHackMode != on:
		if on:
			inHackMode = true
			enterHackMode.emit()
		if !on:
			inHackMode = false
			exitHackMode.emit()
			hackedEnemy = null

var p = preload("res://Player/Player.tscn")
func createPlayer() -> Player:
	var newP : Player = p.instantiate()
	return newP

func getPlayerData() -> SmallPlayerData:
	var s : SmallPlayerData = SmallPlayerData.new()
	s.health = player.healthComponent.get_health()
	return s

func addProjectile(projectile):
	littleLevel.addProjectile(projectile)

func addEnemy(enemy):
	littleLevel.addEnemy(enemy)

func superParry(pos : Node2D):
	if player:
		player.screenEffects.superParry(pos)

func respawnPlayer():
	if !respawnData:
		littleViewport.switchScene(littleLevel.doors[0].getSceneSwitchData())
		return
	
	var d = SceneSwitchData.new()
	d.respawnPlayer = true
	d.respawnData = respawnData
	d.scene = respawnData.scene
	
	littleViewport.switchScene(d)

func deletePlayer():
	player.queue_free()
	player = null

func doesPlayerExist() -> bool:
	if player:
		if is_instance_valid(player):
			return true
	return false

func doesCameraExist() -> bool:
	if camera:
		if is_instance_valid(camera):
			return true
	return false

func doesBigPlayerExist() -> bool:
	if bigPlayer:
		if is_instance_valid(bigPlayer):
			return true
	return false

func doesBigCameraExist() -> bool:
	if bigCamera:
		if is_instance_valid(bigCamera):
			return true
	return false

func levelSwitched(sceneDate : SceneSwitchData):
	onLevelSwitch.emit(sceneDate)
