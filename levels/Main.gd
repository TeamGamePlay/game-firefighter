extends Node2D

onready var level1 = preload("res://levels/level_1/World_1.tscn")
var level
var levelRest

func _ready():
	level = level1.instance()
	level.world = self
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
	levelRest = level.sigLevel
	level.queue_free()
	level = levelSig
	self.add_child(level)
