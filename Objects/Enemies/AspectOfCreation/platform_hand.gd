extends Sprite2D

@export var spriteToMirror : Sprite2D
@export var parrent : CharacterBody2D

@onready var off = position
var o
var pos : Vector2 = Vector2.ZERO

func _ready() -> void:
	o = off

func _process(_delta: float) -> void:
	flip_v = spriteToMirror.flip_h
	if flip_v:
		o.x = -off.x
	else:
		o.x = off.x
	position = pos + o

func setPosition():
	pos = parrent.global_position

func fadeIn():
	$PlatforHandAnimator.play("FadeIn")
