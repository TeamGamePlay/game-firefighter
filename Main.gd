extends Node2D

onready var inicio = $CanvasLayer
onready var boton = $CanvasLayer/Button 
onready var tutorial = preload("res://Tutorial.tscn")
onready var levelMain = preload("res://levels/Main.tscn")

func _ready():
	pass

func _on_Button_pressed():
	boton.hide()
	inicio.queue_free()
	var t = tutorial.instance()
	t.main = self
	self.add_child(t)

func iniciarJuego():
	add_child(levelMain.instance())