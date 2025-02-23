extends Node2D
class_name Projectile

@export var numOfPierces : int = 999
@export var destroyOnTerrain : bool = true

var dirVector : Vector2 = Vector2(1.0, 0.0)
@export var speed : float = 1.0
var flipH : bool = false
var flipV : bool = false
@export var friendly = false

func move(dir : Vector2, s : float, delta):
	position += dir * s * delta

func setFriendly(f : bool):
	pass
