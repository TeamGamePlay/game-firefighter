extends Node2D

onready var level1 = preload("res://levels/level_1/World_1.tscn")
var level

func _ready():
	level = level1.instance()
	level.world = self
	self.add_child(level)
	global.connect("reset", self, "reload_reset")

func reload_reset():
	print("levanta reset")
	var levelNew = level1.instance()
	level.queue_free()
	level = levelNew
	level.world = self
	self.add_child(level)
