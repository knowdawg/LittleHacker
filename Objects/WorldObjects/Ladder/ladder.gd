extends Node2D

var rungSpacing : float = 8.0


func getNearestRung(obj : Node2D, offset : float = 0.0):
	var posDif : float = obj.global_position.y - global_position.y
	var distance : int = int(posDif) % int(rungSpacing)
	distance -= offset
	
	if distance > rungSpacing / 2.0:
		distance = rungSpacing - distance
	
	return distance
