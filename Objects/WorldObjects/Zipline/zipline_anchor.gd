@tool
extends Node2D

@export var flipH : bool = false

#@export var points : Dictionary[InteractableComponent, Marker2D]
@export var interactableComponent : InteractableComponent
@export var startingPos : Marker2D
@export var destination : Marker2D
@export var duration : float = 2.0
@export var curve : Curve

@export var applyForceOnExit : bool = true

var playerOnZipline : bool = false
var t = 0.0

func _ready() -> void:
	setup()

func setup():
	if interactableComponent:
		interactableComponent.onInteract.connect(onInteract)
	if startingPos:
		%GrabPos.global_position = startingPos.global_position
	
	%RopeVisual.clear_points()
	if startingPos and destination:
		%RopeVisual.add_point(startingPos.position)
		%RopeVisual.add_point(destination.position)

func onInteract():
	if !destination:
		return
	if Game.player:
		Game.player.ziplineActivated()
		if !Game.player.forceExitZipline.is_connected(ziplineFinished):
			Game.player.forceExitZipline.connect(ziplineFinished)
		
		%GrabComponent.setActive(true, Game.player)
		playerOnZipline = true
		t = 0.0
		
		%AnimationPlayer.play("OnInteract")

#forceExited is true if the player exited the grab and false if the timer ran out
func ziplineFinished(forceExited : bool = true):
	playerOnZipline = false
	%GrabComponent.setActive(false, null, !forceExited)
	%GrabPos.global_position = startingPos.global_position
	%AnimationPlayer.play("OnFinish")
	
	if Game.player:
		if applyForceOnExit:
			var pos : float = t / duration
			
			var s1 : Vector2 = Vector2(pos - 0.05, curve.sample(pos - 0.05))
			var s2 : Vector2 = Vector2(pos, curve.sample(pos))
			
			var direction : Vector2 = startingPos.global_position.direction_to(destination.global_position)
			var slope : float = (s2.y - s1.y) / (s2.x - s1.x)
			var dist : float = startingPos.global_position.distance_to(destination.global_position)
			
			var v : Vector2 = direction * slope * dist
			v /= duration * 2.0
			
			Game.player.boostVector += v
		
		if Game.player.forceExitZipline.is_connected(ziplineFinished):
			Game.player.forceExitZipline.disconnect(ziplineFinished)

func _physics_process(delta: float) -> void:
	if playerOnZipline:
		t += delta
		
		var val : float = curve.sample(t / duration)
		#val = clamp(val, 0.0, 1.0)
		%GrabPos.global_position = lerp(startingPos.global_position, destination.global_position, val)
		
		if t >= duration:
			ziplineFinished(false)

func _process(delta: float) -> void:
	$ZiplineAnchorSprite.flip_h = flipH
