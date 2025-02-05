extends Area2D
class_name LevelTransition

@export var scene : String

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if scene:
			var s = SceneSwitchData.new()
			s.scene = self.scene
			Game.littleViewport.call_deferred("switchScene", s)
		else:
			printerr("No Scene To Switch To!")

func _ready() -> void:
	Game.littleViewport.threadLoadScene(scene)
