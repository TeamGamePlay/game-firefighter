extends Node

func _ready():
	pass # Replace with function body.

func _on_Fighter_shoot(water, _position, _direction):
	var b = water.instance()
	add_child(b)
	b.start(_position, _direction)