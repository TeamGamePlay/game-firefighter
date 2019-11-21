extends Node


onready var player = $Player
onready var canvas = $UI/Control
onready var matafuego = $Player/Matafuego
onready var tile = $TileMap

onready var sigLevel
onready var ganaste = preload("res://Label/Ganaste.tscn")
onready var sigNivel = preload("res://Label/SiguienteNivel.tscn")

var world

func _ready():
	canvas.player = player
	canvas.matafuego = matafuego
	pass
	
func _on_Fighter_shoot(water, _position, _direction):
	var b = water.instance()
	add_child(b)
	b.start(_position, _direction)
