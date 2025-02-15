extends CanvasLayer

@onready var energyIcon = $EnergyIcon

@export var healthComponent : HealthComponent

@export var highlight : Line2D
@export var backgroundLine : Line2D
@export var middleLine : Line2D

@onready var healthNodes : Array[Node] = $HealthNodes.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in healthNodes.size():
		healthNodes[i].visible = healthComponent.MAX_HEALTH > i


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var startPoint : Vector2
	var endPoint : Vector2
	startPoint = Vector2(60, 56)
	endPoint = Vector2(30 + (healthComponent.MAX_HEALTH -1) * 40, 56)
	endPoint.x += startPoint.x
	
	backgroundLine.clear_points()
	backgroundLine.add_point(startPoint)
	backgroundLine.add_point(endPoint)
	
	middleLine.clear_points()
	middleLine.add_point(startPoint)
	middleLine.add_point(endPoint)
	
	highlight.clear_points()
	highlight.add_point(startPoint)
	var hEnd = Vector2(startPoint.x + 30 + (healthComponent.health -1) * 40, 56)
	highlight.add_point(hEnd)
	
	for i in healthNodes.size():
		if healthComponent.health >= (i + 0.9999): #floating point acuracy
			healthNodes[i].showFull()
			
		else:
			if healthComponent.health >= i:
				var a : float = healthComponent.health - floor(healthComponent.health)
				healthNodes[i].showFilling(a)
			else:
				healthNodes[i].showFilling(0.0)
	
	if healthComponent.health == healthComponent.MAX_HEALTH:
		energyIcon.material.set_shader_parameter("BLOOM_THRESHOLD", 0.7)
	else:
		energyIcon.material.set_shader_parameter("BLOOM_THRESHOLD", 1.0)
