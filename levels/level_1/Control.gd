extends Control

var oxigeno = 1500
var vida = 300
onready var barraAgua = get_node("LevelWater")
onready var barraVida = get_node("LevelLife")

var player
var matafuego

func _ready():
	global.connect("smoke", self, "smoke")
	global.connect("fire", self, "fire")
	global.connect("fire2", self, "fire2")
	global.connect("water", self, "water")
	global.connect("recharge", self, "recharge")
	$score.text = "Oxigeno: " + str(oxigeno)
	pass

	
func smoke(s):
	oxigeno -= 10
	player.quitaOxigeno(oxigeno)
	$score.text = "Oxigeno: " + str(oxigeno)

func fire(s):
	vida -= 30
	player.quitaVida(vida)
	
	
func fire2(s):
	barraVida.value = barraVida.value - 30

func water(s):
	 barraAgua.value = barraAgua.value - 0.05
	 if barraAgua.value == 0:
	    player.desactivarMatafuego()
	    print("NO HAY MAS AAGUAAAAAAAA!!!!")
			
func recharge(s):
	barraAgua.value = 100
