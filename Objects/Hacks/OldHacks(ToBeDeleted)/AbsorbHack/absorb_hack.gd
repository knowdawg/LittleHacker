extends Node2D

@export var orbs : Array[Marker2D]
@export var speed = 50.0
@export var speedCurve : Curve

func initialize():
	$AnimationPlayer.play("Hack")

var t = 0.0
func _process(delta: float) -> void:
	t += delta
	var speedMultiplier = speedCurve.sample(t)
	
	if t <= 0.5: #flip point
		for i in orbs.size():
			var angle = (PI * i) / 3.0
			var vec = Vector2(cos(angle), sin(angle)).normalized()
			orbs[i].position += vec * delta * speed * speedMultiplier
			
	if t > 0.5:
		if Game.player:
			for o in orbs:
				var vec = o.global_position - Game.player.global_position
				vec = -vec.normalized()
				o.position += vec * delta * speed * speedMultiplier
	
	var indeciesToRemove : Array = []
	if Game.player:
		for i in orbs.size():
			if orbs[i].global_position.distance_to(Game.player.global_position) < 1:
				indeciesToRemove.append(i)
	
	if indeciesToRemove.size() > 0:
		var o = orbs[indeciesToRemove[0]]
		orbs.remove_at(indeciesToRemove[0])
		o.queue_free()
	
	if orbs.size() == 0:
		queue_free()
