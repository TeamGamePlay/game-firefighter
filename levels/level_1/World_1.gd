extends Node


onready var player = $Player
onready var canvas = $UI/Control

func _ready():
	canvas.player = player
	
func _on_Fighter_shoot(water, _position, _direction):
	var b = water.instance()
	add_child(b)
	b.start(_position, _direction)
