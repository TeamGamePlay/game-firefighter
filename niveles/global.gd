extends Node2D

var vida = 0
onready var barraAgua = get_node("LevelWater")
onready var barraVida = get_node("LevelLife")
onready var barraOxigeno = get_node("LevelOxigeno")


signal smoke
signal fire
signal water
signal apagarF
signal reset
signal fire2
signal recharge
signal rechargeOxigen

func _ready():
	pass # Replace with function body.

func _on_smoke():
	emit_signal("smoke", barraOxigeno)
	
func _on_fire():
	emit_signal("fire", vida)
	
func _on_fire2():
	emit_signal("fire2", barraVida)
	
func _on_water():
	emit_signal("water", barraAgua)
	
func apagar_fuego(pos):
	emit_signal("apagarF", pos)

func _on_reset():
	emit_signal("reset")
	
func _on_recharge_water():
	emit_signal("recharge", barraAgua)

func _on_recharge_oxigeno():
	emit_signal("rechargeOxigen", barraOxigeno)
