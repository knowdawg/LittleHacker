extends SwitchStateHack
class_name MeatChunkHack

@export_group("Chunk Parameters")
@export var numOfChunks : int = 3
@export var chunkCreationLocation : Node2D
@export var angle : float = 0.0
@export var spread : float = 30
@export var chunkForce : float = 50.0
@export var healAmount : float = 0.5


var meatChunk = preload("uid://bnr6ghhy2d1s")

func customExecute():
	for i in range(numOfChunks):
		var m : MeatChunk = meatChunk.instantiate()
		
		var a : float = angle + (randf_range(-1.0, 1.0) * spread)
		a /= 360.0
		a *= PI * 2.0
		
		m.dir = Vector2(cos(a), sin(a))
		m.force = chunkForce
		m.healAmount = healAmount
		
		Game.addEnemy(m)
		
		m.global_position = chunkCreationLocation.global_position
