extends Resource
class_name PlayerSaveData



var abilities : Dictionary[String, bool] = {
	"VoidPin" : false
}

#Arenas:
var arenas : Dictionary[String, bool] = {
	"beforeTheCarcassArena" : false
}



#const SAVE_PATH : String = "res://Resources/SaveFile.tres"
#
#func saveData():
	#ResourceSaver.save(self, SAVE_PATH)
#
#func loadData():
	#if ResourceLoader.exists(SAVE_PATH):
		#return load(SAVE_PATH)
	#else:
		#return PlayerSaveData.new()
