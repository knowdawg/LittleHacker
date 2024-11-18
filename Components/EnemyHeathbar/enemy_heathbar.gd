extends Node
class_name EnemyHealthBar

@export var follow : Node2D
@export var healthComponent : HealthComponent
@export var hackCommands : Array[HackCommandComponent]
@export var stateMachine : StateMachine

@export_group("Bar Catagories")
@export var nuetralActiveBars : Array[TextureProgressBar]
@export var healthActiveBars : Array[TextureProgressBar]
@export var weaknessActiveBars : Array[TextureProgressBar]
@export var healthBars : Array[TextureProgressBar]
@export var weaknessBars : Array[TextureProgressBar]


func _ready() -> void:
	$Sprite2D.visible = false
	curBar = "neither"
	EnemyHealthBarPositionManager.addHealthbar(self)
	healthComponent.death.connect(delete)
	
	if stateMachine:
		stateMachine.onHacked.connect(addCommandsToGame)
	
	drawLines()

func addCommandsToGame():
	for i in hackCommands:
		Game.hacks.append(i)

func delete(_attack):
	if active:
		deactivate()
	EnemyHealthBarPositionManager.removeHealbar(self)
	

func drawLines():
	if is_instance_valid(Game.player):
		if Game.player.global_position.x > follow.global_position.x:
			pass
		else:
			pass
	
	hackCommands.sort_custom(sortHacks)
	var endPositions : Array = $Sprite2D/HackCoponentPosition.get_children()
	
	var yPos = 13.0 / 4.0
	var xOffeset = 14.0 / 4.0
	for i in hackCommands.size():
		var startPos = hackCommands[i].cost / healthComponent.get_max_weakness()
		startPos *= 11.0 #num of pixels
		hackCommands[i].clear_points()
		hackCommands[i].add_point(Vector2(startPos + xOffeset, yPos) + follow.global_position)
		hackCommands[i].add_point(Vector2(startPos + xOffeset, yPos + 2.5) + follow.global_position)
		hackCommands[i].add_point(endPositions[i].position * 0.25 + follow.global_position)


func sortHacks(a : HackCommandComponent, b : HackCommandComponent):
	if a.cost < b.cost:
		return true
	else:
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	drawLines()
	
	var healthPercentage : float = healthComponent.get_health() / healthComponent.get_max_health()
	var weaknessPercentage : float = healthComponent.get_weakness() / healthComponent.get_max_weakness()
	
	for a in healthBars:
		a.value = healthPercentage * 100.0
	for a in weaknessBars:
		a.value = weaknessPercentage * 100.0
	
	$Sprite2D.position = follow.global_position
	
	$Sprite2D/HealthLabel.text = str(healthComponent.get_health()) + "/" + str(healthComponent.get_max_health())
	$Sprite2D/WeaknessLabel.text = str(healthComponent.get_weakness())
	$Sprite2D/HealthLabel.visible = curBar == "health"
	$Sprite2D/WeaknessLabel.visible = curBar == "weakness"
	
	for a in hackCommands:
		a.visible = curBar == "weakness"
	
	for a in hackCommands:
		if a.cost <= healthComponent.get_weakness():
			a.setActive(true)
		else:
			a.setActive(false)
	
	for a in nuetralActiveBars:
		a.visible = curBar == "neither"
	for a in healthActiveBars:
		a.visible = curBar == "health"
	for a in weaknessActiveBars:
		a.visible = curBar == "weakness"

var active = false
func activate():
	active = true
	$Sprite2D.visible = true
	$AnimationPlayer.play("Activate")
	HackCommandManager.selectedHealthBar = self

func deactivate():
	active = false
	curBar = "neither"
	$AnimationPlayer.play("Deactivate")
	HackCommandManager.selectedHealthBar = null

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Deactivate":
		$Sprite2D.visible = false

var curBar = "neither"
func nextBar():
	$AnimationPlayer.play("Glitch")
	if curBar == "neither":
		curBar = "health"
		$Sprite2D.frame = 1
	elif curBar == "health":
		curBar = "weakness"
		$Sprite2D.frame = 2
	elif curBar == "weakness":
		curBar = "health"
		$Sprite2D.frame = 1
