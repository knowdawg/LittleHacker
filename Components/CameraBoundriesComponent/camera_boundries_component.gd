extends Polygon2D
class_name CameraCoundriesComponent

@export var exstendUp : bool = true
@export var exstendDown : bool = true
@export var exstendLeft : bool = true
@export var exstendRight : bool = true

var leftLimit : float = PI #set to PI when nothing else has been met
var rightLimit : float = PI
var upLimit : float = PI
var downLimit : float = PI


func set_bounds():
	var points = polygon
	for p in points:
		var curX = (p.x * scale.x) + global_position.x
		var curY = (p.y * scale.y) + global_position.y
		if leftLimit == PI:
			leftLimit = curX
		if rightLimit == PI:
			rightLimit = curX
		if upLimit == PI:
			upLimit = curY
		if downLimit == PI:
			downLimit = curY
		
		if curX < leftLimit:
			leftLimit = curX
		if curX > rightLimit:
			rightLimit = curX
		if curY > downLimit:
			downLimit = curY
		if curY < upLimit:
			upLimit = curY
	
	if exstendLeft == true:
		leftLimit -= 1000
	if exstendRight == true:
		rightLimit += 1000
	if exstendDown == true:
		downLimit += 1000
	if exstendUp == true:
		upLimit -= 1000
	

func _ready():
	set_bounds()
	visible = false
	$Area2D/CollisionPolygon2D.polygon = polygon
	
