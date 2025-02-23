extends Node2D
class_name GenericLevel

@export var projectileSpawnNode : Node2D
@export var enemySpawnLocation : Node2D

@export_group("PlayerSpawnDetails")
@export var doorToSpawnPlayerOnFailure : LevelTransition
@export var doors : Array[LevelTransition] = []
@export var whereToAddPlayer : Node2D

@export_group("Lighting")
@export var lighting : ColorRect
@export var lightingBrightness : float = 1.0

#Called by SceneTransitionManager When the level is ready
func initializeLevel(sceneData : SceneSwitchData) -> void:
	if lighting:
			lighting.material.set_shader_parameter("brightness", lightingBrightness)
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

func addProjectile(projectile):
	projectileSpawnNode.add_child(projectile)

func addEnemy(enemy):
	enemySpawnLocation.add_child(enemy)
