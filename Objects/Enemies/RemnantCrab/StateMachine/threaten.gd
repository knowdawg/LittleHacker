extends GenericTransitionState

@export var bossInro : BossIntro
@export var parent : RemnantCrab

func customEnter(_p):
	bossInro.play()
	if Game.doesCameraExist():
		Game.camera.setNodeToTrack(parent)

func customExit(_n):
	if Game.doesCameraExist() and Game.doesPlayerExist():
		Game.camera.setNodeToTrack(Game.player)
