extends StateMachine
class_name RemnantCrabStateMachine

@export var enemyHealthBar : EnemyHealthBar

@export_group("Phase 1")
@export var phase1Hurtbox : HurtboxComponent
@export var phase1Hacks : Array[HackCommandComponent]

@export_group("Phase 2")
@export var phase2Hurtbox : HurtboxComponent
@export var phase2Hacks : Array[HackCommandComponent]


var phase : int = 1
enum phase1Attacks {Stomp, Jump, HeadSlam, LazerRun, SuckIn, SpikeFloor}
enum phase2Attacks {MassiveLaser, BlackHoleDisk, DoubleHeadSwing, Jump2}

func customReady():
	updatePhase()

func updatePhase():
	if phase == 1:
		phase1Hurtbox.call_deferred("enable")
		phase2Hurtbox.call_deferred("disable")
		enemyHealthBar.hackCommands = phase1Hacks
	if phase == 2:
		phase1Hurtbox.call_deferred("disable")
		phase2Hurtbox.call_deferred("enable")
		enemyHealthBar.hackCommands = phase2Hacks

func getRandomAttack(ignore : phase1Attacks = -1):
	var a : phase1Attacks = ignore
	while a == ignore:
		a = randi_range(0, phase1Attacks.size() - 1)
	return a

func getRandomAttackPhase2(ignore : phase2Attacks = -1):
	var a : phase2Attacks = ignore
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


func switchPhases():
	phase = 2
	updatePhase()
	
