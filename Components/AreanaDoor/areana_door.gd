extends StaticBody2D
class_name ArenaDoor

@export var enemyWaveManager : EnemyWaveManager

#add suport for a sprite and animation later

func _ready() -> void:
	enemyWaveManager.onStartEncounter.connect(start)
	enemyWaveManager.onEndEncounter.connect(end)

func start():
	set_collision_layer_value(1, true)

func end():
	set_collision_layer_value(1, false)
