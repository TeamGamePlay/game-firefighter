extends Control

var oxigeno = 1500
var vida = 1500
onready var barraAgua = get_node("LevelWater")
onready var barraVida = get_node("LevelLife")
onready var barraOxigeno = get_node("LevelOxigeno")

var player
var matafuego

func _ready():
	global.connect("smoke", self, "smoke")
	global.connect("fire", self, "fire")
	global.connect("fire2", self, "fire2")
	global.connect("water", self, "water")
	global.connect("recharge", self, "recharge")
	global.connect("rechargeOxigen",self, "rechargeOxigen")
	pass

	
func smoke(s):
	if player.tieneMascara():
		oxigeno -= 10
		player.quitaOxigeno(oxigeno)
		barraOxigeno.value = barraOxigeno.value - 10
	else:
		oxigeno -= 30
		player.quitaOxigeno(oxigeno)
		barraOxigeno.value = barraOxigeno.value - 30


func fire(s):
	if player.tieneMascara():
		pass
	else:
		vida -= 30
		player.quitaVida(vida)
	
	
func fire2(s):
	if player.tieneMascara():
		pass
	else:
		barraVida.value = barraVida.value - 30

func water(s):
	 barraAgua.value = barraAgua.value - 0.05
	 if barraAgua.value == 0:
	    player.desactivarMatafuego()
	    print("NO HAY MAS AAGUAAAAAAAA!!!!")
			
func recharge(s):
	barraAgua.value = 100
	
func rechargeOxigen(s):
	barraOxigeno.value = 1500
	oxigeno = 1500
	player.restablecerOxigeno()
