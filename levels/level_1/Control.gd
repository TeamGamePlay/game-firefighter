extends Control

var oxigeno = 200

var player

func _ready():
	global.connect("smoke", self, "smoke")
	$score.text = "Oxigeno: " + str(oxigeno)
	pass
	
func smoke(s):
	oxigeno -= 20
	player.quitaOxigeno(oxigeno)
	$score.text = "Oxigeno: " + str(oxigeno)
