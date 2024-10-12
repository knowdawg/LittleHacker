extends State
class_name PlayerWallCling

@export var playerSprite : Sprite2D
@export var animator : AnimationPlayer
@export var player : Player
@export var scaleAnimtor : AnimationPlayer
@export var playerStateMachine : PlayerStateMachine
@export var slideSpeedCurve : Curve

var slideTimer = 0.0
func update_physics(delta):
	slideTimer += delta * 4.0
	player.slideVector.y = slideSpeedCurve.sample(slideTimer) * 20.0
	
	player.update_physics(delta, false, true)
	
	if playerStateMachine.getInputBuffer() == "Jump":
		trasitioned.emit(self, "Jump")
		playerStateMachine.resetInputBuffer()
		return
	if abs(player.velocity.x) > 5.0:
		trasitioned.emit(self, "Fall")
		return
	if player.is_on_floor():
		playerSprite.flip_h = !playerSprite.flip_h
		trasitioned.emit(self, "Fall")
		return
	if !player.is_on_wall():
		playerSprite.flip_h = !playerSprite.flip_h
		trasitioned.emit(self, "Fall")
		return

func enter(_prevState):
	slideTimer = 0.0
	player.v.y = 0
	scaleAnimtor.play("WallCling")
	animator.play("WallCling")

func exit(_nextState):
	player.slideVector = Vector2.ZERO
	var dir = cos(player.get_wall_normal().angle())
	player.position.x += 0.01 * dir
