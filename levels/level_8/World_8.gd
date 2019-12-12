extends Node2D


onready var player = $Player
onready var canvas = $UI/Control
onready var matafuego = $Player/Matafuego
onready var tile = $TileMap

onready var sigLevel = preload("res://levels/level_9/World_9.tscn")
onready var ganaste = preload("res://Label/Ganaste.tscn")
onready var sigNivel = preload("res://Label/SiguienteNivel.tscn")
onready var gameOver = preload("res://Label/GameOver.tscn")

var world
var numLevel

func _ready():
	canvas.player = player
	canvas.matafuego = matafuego
	tile.world = self
	
func _on_Fighter_shoot(water, _position, _direction):
	var b = water.instance()
	add_child(b)
	b.start(_position, _direction)

func siguienteNivel():
	world.siguienteNivel()

func gano():
	if(sigLevel == null):
		var newGanaste = ganaste.instance()
		newGanaste.world = get_parent()
		self.add_child(newGanaste)
	else:
		var newSigNivel = sigNivel.instance()
		newSigNivel.world = get_parent()
		newSigNivel.texto = "Next Level " + str(numLevel) + " !!!"
		self.add_child(newSigNivel)
		
func gameOver():
	var newGameOver = gameOver.instance()
	self.add_child(newGameOver)