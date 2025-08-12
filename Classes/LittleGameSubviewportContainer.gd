@tool
extends SubViewportContainer
class_name LittleGameSubviewportContainer



@export_group("ContainerOverides")
@export var disable3D : bool = true
@export var tranparentBackGround : bool = true
@export var handleInputLocaly : bool = false


@export_group("Sub Viewport")
@export var subViewport : SubViewport
@export var renderTarget : SubViewport.UpdateMode = SubViewport.UpdateMode.UPDATE_DISABLED
@export var fps := 10.0
@export var oclutionCulling : VisibleOnScreenEnabler2D


@export_group("Depth of Field")
@export var scalingContainer : Node2D
@export_range(0.0, 1.0) var depth : float = 0.0
@export var scaleBasedOnDepth : bool = true
@export var filterLinear : bool = false
@export_tool_button("Update Depth", "Callable") var u = updateDepth

func updateDepth():
	material.set_shader_parameter("depth", depth)
	material.set_shader_parameter("u_radius", depth)
	
	if scaleBasedOnDepth:
		if scalingContainer:
			scalingContainer.scale = Vector2(1.0 - depth, 1.0 - depth)
			scale = Vector2(1.0, 1.0) / Vector2(1.0 - depth, 1.0 - depth)
	
	if filterLinear:
		texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	else:
		texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	updateOclutionCulling()

var t = 0.0
func _process(delta: float) -> void:
	if !subViewport:
		return
	
	if renderTarget == SubViewport.UpdateMode.UPDATE_DISABLED:
		t += delta
		var frame : float = 1.0 / fps
		if t >= frame:
			
			subViewport.render_target_update_mode = SubViewport.UPDATE_ONCE
			t -= frame


func _ready() -> void:
	updateOclutionCulling()
	
	subViewport.disable_3d = disable3D
	subViewport.transparent_bg = tranparentBackGround
	subViewport.handle_input_locally = handleInputLocaly
	
	
	if !subViewport:
		return
	subViewport.render_target_update_mode = renderTarget
	t = randf_range(0, 1.0 / fps)

func updateOclutionCulling():
	if oclutionCulling:
		oclutionCulling.rect = Rect2(0.0, 0.0, size.x, size.y)
		oclutionCulling.position = position
