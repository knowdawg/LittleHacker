@tool
extends Node2D
class_name EnemyHealthBar

@export var showBars : bool = true

@export var parent : CharacterBody2D
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
	if !Engine.is_editor_hint():
		EnemyHealthBarPositionManager.addHealthbar(self)
		if healthComponent:
			healthComponent.death.connect(delete)
		
		if stateMachine:
			stateMachine.onHacked.connect(enterHackMode)
			stateMachine.onHackFinished.connect(exitHackMode)
		
		hackCommands.sort_custom(sortHacks)

func enterHackMode():
	addCommandsToGame()
	Game.hackedEnemy = parent
	Game.hackedHealthbar = self
	Game.setHackMode(true)

func exitHackMode():
	Game.hackedEnemy = null
	Game.hackedHealthbar = null
	HackCommandManager.clearCommands()

func addCommandsToGame():
	for i in hackCommands:
		HackCommandManager.hackCommands.append(i)

func delete(_attack):
	if active:
		deactivate()
	EnemyHealthBarPositionManager.removeHealbar(self)
	%Healthbars.modulate = Color(1.0, 1.0, 1.0, 0.0)
	

func sortHacks(a : HackCommandComponent, b : HackCommandComponent):
	if a.cost < b.cost:
		return true
	else:
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if follow:
		global_position = Vector2.ZERO
		%Healthbars.global_position = follow.global_position
	
	if showBars:
		%Healthbars.visible = true
	else:
		%Healthbars.visible = false
	
	if !Engine.is_editor_hint():
		if healthComponent:
			var healthPercentage : float = healthComponent.get_health() / healthComponent.get_max_health()
			var weaknessPercentage : float = healthComponent.get_weakness() / healthComponent.get_max_weakness()
			
			%Health.value = healthPercentage * 100.0
			%Weakness.value = weaknessPercentage * 100.0

var active = false
func activate():
	active = true
	$Sprite2D.visible = true
	$AnimationPlayer.play("Activate")

func deactivate():
	active = false
	#curBar = "neither"
	$AnimationPlayer.play("Deactivate")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Deactivate":
		$Sprite2D.visible = false
