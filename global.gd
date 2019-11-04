extends Node2D

var score = 0

signal smoke

func _ready():
	pass # Replace with function body.

func _on_smoke():
	emit_signal("smoke", score)