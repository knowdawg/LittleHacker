extends FollowAudio
class_name EasiInLoopAudio

@export var easeInTime : float = 0.3
@export var easeOutTime : float = 0.3

@export var easeInCurve : Curve
@export var easeOutCurve : Curve

enum states {IDLE, RISING, LOWERING, MUTE}
var curState : states = states.IDLE

@onready var startingDB = volume_db

func playSound():
	t = 0.0
	curState = states.RISING
	volume_db = linear_to_db(0.0)
	play()

func endSound():
	t = 0.0
	curState = states.LOWERING
	volume_db = startingDB
	
func forceEndSound():
	curState = states.MUTE

var t : float = 0.0
func customProcess(delta):
	t += delta
	
	match curState:
		states.IDLE:
			t = 0.0
		
		states.RISING:
			var sampleVal : float = t * (1.0 / easeInTime)
			var linearVol : float = db_to_linear(startingDB) * easeInCurve.sample(sampleVal)
			volume_db = linear_to_db(linearVol)
			
			if linearVol >= 1.0:
				curState = states.IDLE
				return
		
		states.LOWERING:
			var sampleVal : float = t * (1.0 / easeOutTime)
			var linearVol : float = db_to_linear(startingDB) * easeOutCurve.sample(sampleVal)
			volume_db = linear_to_db(linearVol)
			
			if linearVol <= 0.0:
				curState = states.IDLE
				return
		
		states.MUTE:
			t = 0.0
			volume_db = linear_to_db(0.0)
