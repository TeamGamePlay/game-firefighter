extends Node2D


onready var player = $Player
onready var canvas = $UI/Control
onready var matafuego = $Player/Matafuego
onready var tile = $TileMap
onready var camara = $Camera2D
 
onready var sigLevel = preload("res://levels/level_10/World_10.tscn")
onready var ganaste = preload("res://Label/Ganaste.tscn")
onready var sigNivel = preload("res://Label/SiguienteNivel.tscn")
onready var labelPos = preload("res://util/LabelPos.tscn")
onready var gameOver = preload("res://Label/GameOver.tscn")

var world
var numLevel

func _ready():
	canvas.player = player
	canvas.matafuego = matafuego
	tile.world = self
	camara.player = player
	tile.modificarTimer(6)
	
func _on_Fighter_shoot(water, _position, _direction):
	var b = water.instance()
	add_child(b)
	b.start(_position, _direction)

func siguienteNivel():
	world.siguienteNivel()

func gano():
	var label_pos = labelPos.instance()
	if(sigLevel == null):
		var newGanaste = ganaste.instance()
		newGanaste.world = get_parent()
		label_pos.add_child(newGanaste)
		label_pos.position = camara.pos
		camara.add_child(label_pos)
	else:
		var newSigNivel = sigNivel.instance()
		newSigNivel.world = get_parent()
		newSigNivel.texto = "Next Level " + str(numLevel) + " !!!"
		label_pos.add_child(newSigNivel)
		label_pos.position = camara.pos
		camara.add_child(label_pos)
		
func gameOver():
	var label_pos = labelPos.instance()
	var newGameOver = gameOver.instance()
	label_pos.add_child(newGameOver)
	label_pos.position = camara.pos
	camara.add_child(label_pos)