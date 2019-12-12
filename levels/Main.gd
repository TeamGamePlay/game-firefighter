extends Node2D

onready var level1 = preload("res://levels/level_1/World_1.tscn")
var level
var levelRest
var sigLevel = 2

func _ready():
	$sonido/start_game.playing = true
	level = level1.instance()
	level.world = self
	level.numLevel = sigLevel
	sigLevel +=1
	self.add_child(level)
	global.connect("reset", self, "reload_reset")

func reload_reset():
	var levelNew 
	if(levelRest == null):
		levelNew = level1.instance()
		
	else:
		levelNew = levelRest.instance()
	level.queue_free()
	level = levelNew
	level.world = self
	self.add_child(level)
	
func siguienteNivel():
	var levelSig = level.sigLevel.instance()
	levelSig.numLevel = sigLevel
	levelRest = level.sigLevel
	sigLevel +=1
	level.queue_free()
	level = levelSig
	self.add_child(level)
