extends Control

var oxigeno = 200
var vida = 300
var player

func _ready():
	global.connect("smoke", self, "smoke")
	global.connect("fire", self, "fire")
	$score.text = "Oxigeno: " + str(oxigeno)
	$vida.text = "Vida: " + str(vida)
	pass
	
func smoke(s):
	oxigeno -= 20
	$score.text = "Oxigeno: " + str(oxigeno) 
	
func fire(s):
	vida -= 30
	$vida.text = "Vida: " + str(vida)