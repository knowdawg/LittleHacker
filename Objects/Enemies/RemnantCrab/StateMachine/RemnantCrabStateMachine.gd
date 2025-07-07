extends StateMachine
class_name RemnantCrabStateMachine


enum phase1Attacks {Stomp, Jump, HeadSlam, LazerRun, SuckIn, SpikeFloor}

func getRandomAttack(ignore : phase1Attacks = -1):
	var a : phase1Attacks = ignore
	while a == ignore:
		a = randi_range(0, phase1Attacks.size() - 1)
	return a

var stamina := 100.0

var distanceToPlayer := 0.0
var xDisToPlayer := 0.0
var vectorToPlayer := Vector2.ZERO

func custumProcess(_delta):
	if Game.doesPlayerExist():
		vectorToPlayer = Game.player.global_position - parent.global_position
		distanceToPlayer = vectorToPlayer.length()
		xDisToPlayer = Game.player.global_position.x - parent.global_position.x

var nearLeftWall := false
var nearRightWall := false

func custumPhysicsProcess(_delta):
	nearLeftWall = %LeftWallRaycast.is_colliding()
	nearRightWall = %RightWallRaycast.is_colliding()
