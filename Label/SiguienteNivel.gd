extends Control

onready var label = $Label.text

var world
var texto

func _ready():
	$Label.text = str(texto)
	
func _on_Timer_timeout():
	world.siguienteNivel()
