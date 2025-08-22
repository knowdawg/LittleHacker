extends SubViewport

#Does not currently work

@export_dir var savePath : String
@export var imageName : String

func _ready() -> void:
	
	await RenderingServer.frame_post_draw
	get_texture().get_image().save_png(savePath + imageName)
	print("done!")
