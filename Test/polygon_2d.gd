@tool
extends Polygon2D

@export_tool_button("Set UV's", "Callable") var b = setUV

func setUV():
	uv = polygon
