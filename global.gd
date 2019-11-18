extends Node2D

var score = 0
var vida = 0
var agua = 0

signal smoke
signal fire
signal water

func _ready():
	pass # Replace with function body.

func _on_smoke():
	emit_signal("smoke", score)
	
func _on_fire():
	emit_signal("fire", vida)
	
func _on_water():
	emit_signal("water", agua)