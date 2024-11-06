extends Node2D

@export var player : Player
@export var labels : Array[RichTextLabel] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.speed_scale = 10
	Game.enterHackMode.connect(animate)
	Game.exitHackMode.connect(disapear)

var activeHack = 1
var prevActiveHack = -1
func _process(_delta: float) -> void:
	if Game.inHackMode == true:
		if activeHack != prevActiveHack: #If the hack has changed
			prevActiveHack = activeHack
			var s = Game.hacks.size()
			for i in range(s):
				var n : String = Game.hacks[i].hackName
				
				if i <= 2:
					labels[i].text = n
				
				if i == activeHack and labels[activeHack].isCrossed == false:
					var shakeText = "[shake rate=100.0 level=1 connected=0]"
					labels[activeHack].text = shakeText + labels[activeHack].text
			
			
		if Input.is_action_just_pressed("SwitchBar"):
			activeHack += 1
			if activeHack > Game.hacks.size() -1:
				activeHack = 0
		
		if Input.is_action_just_pressed("HackAttack"):
			if !Game.hacks[activeHack].isExecutable():
				if labels[activeHack].isCrossed == false:
					Game.hacks[activeHack].executeHack()
					#Remove Shakyness of text
					labels[activeHack].text = Game.hacks[activeHack].hackName
					#Animations
					labels[activeHack].crossOut()
					$AnimationPlayer.play("SelectHack")
					$SelectLineContainer/SelectParticles.restart()
					$SelectLineContainer/SelectParticles.emitting = true
			
		var d = $SelectLineContainer.rotation_degrees
		if activeHack == 0:
			$SelectLineContainer.rotation_degrees = lerp(d, 9.0, 0.5)
		if activeHack == 1:
			$SelectLineContainer.rotation_degrees = lerp(d, 0.0, 0.5)
		if activeHack == 2:
			$SelectLineContainer.rotation_degrees = lerp(d, -9.0, 0.5)
	else:
		prevActiveHack = -1

func animate():
	activeHack = 1
	$AnimationPlayer.speed_scale = 10
	if player.getSpriteDirection() == -1:
		$AnimationPlayer.play("ShowLeft")
	else:
		$AnimationPlayer.play("ShowRight")

func disapear():
	$AnimationPlayer.speed_scale = 3
	if player.getSpriteDirection() == -1:
		$AnimationPlayer.play("HideLeft")
	else:
		$AnimationPlayer.play("HideRight")
