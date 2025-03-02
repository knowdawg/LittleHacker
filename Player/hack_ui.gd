extends Node2D
class_name SmallPLayerHackUI

@export var player : Player
@export var curentLabels : Array[RichTextLabel] = []

@onready var topLabel : RichTextLabel = $Top
@onready var middleLabel : RichTextLabel = $Middle
@onready var bottomLabel : RichTextLabel = $Bottom

@export var blur : CanvasLayer
@export var camera : SmallPlayerCamera
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.speed_scale = 10
	Game.enterHackMode.connect(animate)
	Game.exitHackMode.connect(disapear)

signal executeHack
var selectedHackIndex = 0
var numOfHacks = 1 #Num of enemy's hacks
func _process(_delta: float) -> void:
	if Game.inHackMode == true:
		curentLabels.clear()
		topLabel.text = ""
		middleLabel.text = ""
		bottomLabel.text = ""
		numOfHacks = HackCommandManager.hackCommands.size()
		if numOfHacks >= 1:
			curentLabels.append(middleLabel)
		if numOfHacks >= 2:
			curentLabels.append(topLabel)
		if numOfHacks >= 3:
			curentLabels.append(bottomLabel)
		
		for i in HackCommandManager.hackCommands.size():
			var h : HackCommandComponent = HackCommandManager.hackCommands[i]
			var n : String = h.hackName
			
			if player.getSpriteDirection() == -1:
				curentLabels[i].text = "[right]" + n
			else:
				curentLabels[i].text = n
			
		if Input.is_action_just_pressed("SwitchBar"):
			selectedHackIndex -= 1
			if selectedHackIndex > curentLabels.size() -1:
				selectedHackIndex = 0
			if selectedHackIndex <  0:
				selectedHackIndex = curentLabels.size() -1
		
		if Input.is_action_just_pressed("HackAttack") or Input.is_action_just_pressed("Attack"):
			if HackCommandManager.hackCommands[selectedHackIndex].isExecutable():
				if curentLabels[selectedHackIndex].isCrossed == false:
					HackCommandManager.hackCommands[selectedHackIndex].execute()
					#Animations
					curentLabels[selectedHackIndex].crossOut()
					$AnimationPlayer.play("SelectHack")
					$SelectLineContainer/SelectParticles.restart()
					$SelectLineContainer/SelectParticles.emitting = true
					
					blur.blur(Game.player)
					Game.camera.set_shake(2.0)
					$Audio/HackExecuted.play()
					camera.zoom = Vector2(15, 15)
					executeHack.emit()
				else:
					$Audio/HackFailed.play()
			else:
				$Audio/HackFailed.play()
			Game.setHackMode(false)
			return
			
		var d = $SelectLineContainer.rotation_degrees
		var mul = -player.getSpriteDirection() #Swap rotation when UI is in oposite direciton
		var weaknessDisplay : String = str("[center]", Game.hackedHealthbar.healthComponent.get_weakness(), "/")
		if selectedHackIndex == 0:
			$SelectLineContainer.rotation_degrees = lerp(d, 0.0, 0.5)
			weaknessDisplay += str(HackCommandManager.hackCommands[0].cost)
		if selectedHackIndex == 1:
			$SelectLineContainer.rotation_degrees = lerp(d, 9.0 * mul, 0.5)
			weaknessDisplay += str(HackCommandManager.hackCommands[1].cost)
		if selectedHackIndex == 2:
			$SelectLineContainer.rotation_degrees = lerp(d, -9.0 * mul, 0.5)
			weaknessDisplay += str(HackCommandManager.hackCommands[2].cost)
		$WeaknessDisplay.text = weaknessDisplay
		
func animate():
	$Audio/HackAttackHit.play()
	$Audio/Fire.play()
	$Audio/HackModeAmbience.play()
	blur.passiveBlur(Game.player)
	selectedHackIndex = 0
	$AnimationPlayer.stop()
	$AnimationPlayer.speed_scale = 10
	if player.getSpriteDirection() == -1:
		$AnimationPlayer.play("ShowLeft")
	else:
		$AnimationPlayer.play("ShowRight")

func disapear():
	blur.stopBlur()
	$Audio/Fire.stop()
	$Audio/HackModeAmbience.stop()
	$AnimationPlayer.speed_scale = 10
	if player.getSpriteDirection() == -1:
		$AnimationPlayer.play("HideLeft")
	else:
		$AnimationPlayer.play("HideRight")
