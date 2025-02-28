extends State

@export var sm : AspectOfCreationStateMachine

@export var spriteDirector : SpriteDirectorComponent

@export_group("Animation")
@export var animator : AnimationPlayer
@export var animationName : String = ""


func enter(_prevState):
	animator.play(animationName)

func update(_delta):
	spriteDirector.lookAtPlayer()
	
	if sm.distToPlayer < 5: #to close
		trasitioned.emit(self, "RunAwayFromPlayer")
	elif sm.distToPlayer < 20: #in range
		var r : int
		r = randi_range(0, 5)
		if r == 0:
			trasitioned.emit(self, "GroundSlideAttack")
		
		r = randi_range(0, 2)
		if r != 0:
			trasitioned.emit(self, "Punch")
		else:
			trasitioned.emit(self, "Scoop")
	elif sm.distToPlayer < 40:
		var r = randi_range(0, 1)
		if r == 0:
			trasitioned.emit(self, "Scoop")
		else:
			trasitioned.emit(self, "RunTowardsPlayer")
	else: #to far away
		trasitioned.emit(self, "RunTowardsPlayer")
