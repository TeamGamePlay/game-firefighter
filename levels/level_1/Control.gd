extends Control

var oxigeno = 200
var vida = 300
var agua = 1000

var player
var matafuego

func _ready():
	global.connect("smoke", self, "smoke")
	global.connect("fire", self, "fire")
	global.connect("water", self, "water")
	$score.text = "Oxigeno: " + str(oxigeno)
	$vida.text = "Vida: " + str(vida)
	$agua.text = "Agua: " + str(agua)
	pass
	
func smoke(s):
	oxigeno -= 20
	player.quitaOxigeno(oxigeno)
	$score.text = "Oxigeno: " + str(oxigeno)

func fire(s):
	vida -= 30
	player.quitaVida(vida)
	$vida.text = "Vida: " + str(vida)
	
func water(s):
	agua -= 1
	matafuego.quitaAgua(agua)
	$agua.text = "Agua: " + str(agua)
