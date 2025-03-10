extends Area2D
class_name LevelTransition

@export_group("Scene Switch Data")
@export var scene : String
@export var doorName : String

enum dir{LEFT, RIGHT} #Left is 0, Right is 1
@export_group("Door Details")
@export var enterPosition : Marker2D
@export var directionToFaceWhenEnteringTHISDoor : dir = dir.LEFT

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if scene:
			var s = getSceneSwitchData()
			Game.littleViewport.call_deferred("switchScene", s)
			
		else:
			printerr("No Scene To Switch To!")

#func _ready() -> void:
	#if Game.littleViewport:
		#Game.littleViewport.threadLoadScene(scene)

func getSceneSwitchData() -> SceneSwitchData:
	var s = SceneSwitchData.new()
	s.scene = self.scene
	s.doorName = doorName
	s.faceRight = true if directionToFaceWhenEnteringTHISDoor == dir.RIGHT else false
	s.playerData = Game.getPlayerData()
	
	return s
