extends Control

var oxigeno = 2000
var vida = 1000
onready var barraAgua = get_node("LevelWater")
onready var barraVida = get_node("LevelLife")
onready var barraOxigeno = get_node("LevelOxigeno")
onready var mascara = get_node("mask")
onready var info = get_node("info")
onready var llave = get_node("llave")

var player
var matafuego

func _ready():
	global.connect("smoke", self, "smoke")
	global.connect("fire", self, "fire")
	global.connect("fire2", self, "fire2")
	global.connect("water", self, "water")
	global.connect("recharge", self, "recharge")
	global.connect("rechargeOxigen",self, "rechargeOxigen")
	global.connect("info", self, "info")
	global.connect("info_out", self, "info_out")
	global.connect("keys", self, "keys")
	pass

	
func smoke(s):
	if player.tieneMascara():
		oxigeno -= 70
		player.quitaOxigeno(oxigeno)
		barraOxigeno.value = barraOxigeno.value - 70
	else:
		oxigeno -= 120
		player.quitaOxigeno(oxigeno)
		barraOxigeno.value = barraOxigeno.value - 120


func fire(s):
	#Si tiene mascara, no quita vida (dentro del fuego).
	if player.tieneMascara():
		pass
	else:
		vida -= 70
		player.quitaVida(vida)
	
	
func fire2(s):
	if player.tieneMascara():
		pass
	else:
		barraVida.value = barraVida.value - 70

func water(s):
	 barraAgua.value = barraAgua.value - 0.07
	 if barraAgua.value == 0:
	    player.desactivarMatafuego()
			
func recharge(s):
	#Recarga de agua con la bomba.
	player.sonidoDeAgua()
	barraAgua.value = 100
	
func rechargeOxigen(s):
	barraOxigeno.value = 2000
	oxigeno = 2000
	player.restablecerOxigeno()

func info(s):
	mascara.region_enabled = false
	info.region_enabled = false
	
func info_out(s):
	mascara.region_enabled = true
	info.region_enabled = true
	
func keys(s):
	llave.region_enabled = false