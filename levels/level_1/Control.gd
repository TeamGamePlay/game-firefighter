extends Control

var oxigeno = 200
var vida = 300
onready var barraAgua = get_node("LevelWater")

var player
var matafuego

func _ready():
	global.connect("smoke", self, "smoke")
	global.connect("fire", self, "fire")
	global.connect("water", self, "water")
	$score.text = "Oxigeno: " + str(oxigeno)
	$vida.text = "Vida: " + str(vida)
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
	 barraAgua.value = barraAgua.value - 0.01
	

