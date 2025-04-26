extends Node2D

var shapes : Array[ColorRect] = []
var myShapes : Array[ColorRect] = []

@onready var shapeHolder = $CurFrame/ShapeHolder
@onready var prevFrame = $PrevFrame/Final
@onready var texture = $CanvasLayer/Texture

var screenUVMaterial : ShaderMaterial = preload("res://Assets/Shaders/ScreenUvShader.tres")


var prevCamPos : Vector2 = Vector2.ZERO
var totalCameraPosChange : Vector2 = Vector2.ZERO
func _process(_delta: float) -> void:
	
	for i in shapeHolder.get_children():
		i.queue_free()
	myShapes.clear()
	
	for s in shapes:
		if s.color != Color(0.0, 0.0, 0.0, 1.0):
			var myShape = ColorRect.new()
			myShape.color = s.color
			myShape.size = s.size
			
			var m = ShaderMaterial.new()
			m = screenUVMaterial
			myShape.set_material(m)
			
			shapeHolder.add_child(myShape)
			myShape.position = round(s.get_global_transform_with_canvas().origin * 0.1)
	
	if Game.camera:
		var c = Game.camera
		var cameraPositionChange = c.global_position - prevCamPos
		prevCamPos = c.global_position
		
		cameraPositionChange = cameraPositionChange / Vector2(128.0, 72.0)
		prevFrame.material.set_shader_parameter("cameraMovementOffset", cameraPositionChange)
		
		RenderingServer.global_shader_parameter_set("VelocityBuffer", texture.texture)
