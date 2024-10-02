extends Line2D
class_name HackCommandComponent

@export var cost = 0.0
@export var hackName = ""
@export var hackExecuteScene : PackedScene
@export var enemy : Node2D
@export var commandSpawnPos : Node2D
@export var healthComponent : HealthComponent
@export var enemyHealthBar : EnemyHealthBar

func _ready() -> void:
	$Label.text = hackName
	HackCommandManager.addCommand(self)
	healthComponent.death.connect(delete)

func delete():
	HackCommandManager.removeCommand(self)

var wasVisible = false
func _process(_delta: float) -> void:
	if visible != wasVisible:
		showGlitch()
	wasVisible = visible
	
	var offset = Vector2(-3, -1)
	if points.size() > 0:
		$Label.position = points[2] + offset

func showGlitch():
	$AnimationPlayer.play("Glitch")

func setActive(isActive : bool):
	if isActive:
		default_color = "72bed3"
		$Label.add_theme_color_override("font_color", "72bed3")
	else:
		default_color = "ffffff"
		$Label.add_theme_color_override("font_color", "ffffff")

func isExecutable():
	return (healthComponent.get_weakness() >= cost and enemyHealthBar.active)

func executeHack():
	var p = hackExecuteScene.instantiate()
	commandSpawnPos.add_child(p)
	p.initialize()
	healthComponent.set_weakness(healthComponent.get_weakness() - cost)
