extends SpecialCameraZone

@export var cameraPos : Marker2D
@export var smoothness : float = 0.3
@export var timeBased : bool = false

func getCameraPostion(targetPos : Vector2, closestPoint : Vector2) -> Vector2:
	if timeBased:
		inZone = true
		var smoothTime = smoothstep(0.0, 1.0, timeInZone / smoothness)
		return lerp(targetPos, cameraPos.global_position, clamp(smoothTime, 0.0, 1.0))
	
	if cameraPos:
		var size = getGlobalSize()
		var pWeight : float
		var dis : float = closestPoint.distance_to(targetPos)
		if size.x < size.y:
			pWeight = dis / size.x
		else:
			pWeight = dis / size.y
		pWeight = smoothstep(0.0, smoothness, pWeight)
		
		return lerp(targetPos, cameraPos.global_position, clamp(pWeight, 0.0, 1.0))
		
	return targetPos

var inZone : bool = false
var timeInZone = 0.0
func _process(delta: float) -> void:
	if inZone:
		timeInZone += delta
		inZone = false
	else:
		timeInZone = 0.0
