extends Control

var world

func _ready():
	pass
	
func _on_Timer_timeout():
	world.siguienteNivel()
