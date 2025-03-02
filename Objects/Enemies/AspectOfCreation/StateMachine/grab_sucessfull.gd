extends State

@export var handSprite : Sprite2D
@export var grabMarker : Marker2D

@onready var handStartingPos = handSprite.position
@onready var markerStartingPos = grabMarker.position

@export_group("Animation")
@export var animator : AnimationPlayer
@export var animationName : String = ""
@export var animationLength : float

func enter(_prevState):
	handSprite.position = handStartingPos
	grabMarker.position = markerStartingPos
	animator.play(animationName)
	t = 0.0

var t = 0.0
func update(delta):
	t += delta
	if t >= animationLength:
		trasitioned.emit(self, "Idle")

func exit(_nextState):
	handSprite.position = handStartingPos
	grabMarker.position = markerStartingPos
