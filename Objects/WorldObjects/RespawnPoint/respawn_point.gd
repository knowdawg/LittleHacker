extends Node2D
class_name RespawnPoint

@export var level : GenericLevel
@export var respawnPointName : String = ""
@export var spawnLocation : Marker2D

var curSceneData : SceneSwitchData
var created = false
func spawnPlayer(sceneSwitchData : SceneSwitchData):
	curSceneData = sceneSwitchData
	$AnimationPlayer.play("NewDroid")

func createPlayer():
	created = true
	Game.respawnData = getRespawnData()
	var p = Game.createPlayer()
	p.initialize(curSceneData)
	level.whereToAddPlayer.add_child(p)
	p.position = spawnLocation.global_position

func getRespawnData() -> RespawnData:
	var rd = RespawnData.new()
	rd.respawnPointName = respawnPointName
	rd.scene = level.scene_file_path
	return rd


func _process(_delta: float) -> void:
	var p : CameraCoundriesComponent = $CameraBounds.get_camera_bounds()
	if p:
		var targetPos = p.closest_rectangle_position(global_position)
		%Camera2D.global_position = targetPos


func _on_interactable_area_on_interact() -> void:
	Game.respawnData = getRespawnData()
	Game.deletePlayer()
	%Camera2D.enabled = true
	%Camera2D.make_current()
	if created == false:
		created = true
		$AnimationPlayer.play("CreateRespawn")
	else:
		$AnimationPlayer.play("NewDroid")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "CreateRespawn":
		if curSceneData:
			spawnPlayer(curSceneData)
		else:
			var s : SceneSwitchData = SceneSwitchData.new()
			s.respawnPlayer = true
			s.respawnData = getRespawnData()
			s.scene = getRespawnData().scene
			spawnPlayer(s)
	if anim_name == "NewDroid":
		$AnimationPlayer.play("Idle")
