extends Node2D
class_name EnemyWaveManager

@export var saveFileName : String = ""

@export_group("Spawn Details")
@export var triggerArea : Area2D
@export var startDelay : float = 1.0
@export var waveDelay : float = 1.0
@export var finalWave : int = 0

@export_group("Waves")
@export var wave0 : Array[Enemy]
@export var wave1 : Array[Enemy]
@export var wave2 : Array[Enemy]
@export var wave3 : Array[Enemy]
@export var wave4 : Array[Enemy]

var waves : Array[Array] = []

signal onStartEncounter
signal onNextWave(waveCount : int)
signal onEndEncounter

var wave = -1
var started : bool = false
var ended : bool = false

func _ready() -> void:
	waves.append(wave0)
	waves.append(wave1)
	waves.append(wave2)
	waves.append(wave3)
	waves.append(wave4)
	if triggerArea:
		triggerArea.body_entered.connect(onBodyEntered)
	
	if SaveDataManager.saveData.arenas.get(saveFileName):
		for w in waves:
			for e : Enemy in w:
				e.queue_free()



func onBodyEntered(b : Node2D):
	if !started and !ended:
		if b is Player:
			startEncounter()

var numOfEnemiesLeft : int = 0
func nextWave():
	wave += 1
	if wave > finalWave:
		endEncounter()
		return
	
	%WaveDelay.start(waveDelay)

func enemyDead(_e):
	numOfEnemiesLeft -= 1
	if numOfEnemiesLeft <= 0:
		nextWave()

func startEncounter():
	if SaveDataManager.saveData.arenas.get(saveFileName):
		return
	
	if !started:
		started = true
		%StartDelay.start(startDelay)
		onStartEncounter.emit()

func endEncounter():
	if !ended:
		ended = true
		onEndEncounter.emit()
		
		SaveDataManager.saveData.arenas.set(saveFileName, true)

func _on_start_delay_timeout() -> void:
	nextWave()


func _on_wave_delay_timeout() -> void:
	onNextWave.emit(wave)
	var curWave : Array[Enemy] = waves[wave]
	numOfEnemiesLeft = curWave.size()
	for e in curWave:
		e.wake()
		e.death.connect(enemyDead)
