extends Node

const SAVE_PATH : String = "user://SaveFile.tres"
var saveData : PlayerSaveData

func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		saveData = ResourceLoader.load(SAVE_PATH)
		print("Sucessfully Loaded save File")
	else:
		print("no save file exists, creating one!")
		var newSave : PlayerSaveData = PlayerSaveData.new()
		ResourceSaver.save(newSave, SAVE_PATH)
		saveData = ResourceLoader.load(SAVE_PATH)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("saving")
		ResourceSaver.save(saveData, SAVE_PATH)
		print("Save complete")
		get_tree().quit()
