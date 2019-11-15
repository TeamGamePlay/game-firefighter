extends Node2D

onready var water = $Particles2D
#var count = 20

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if count - 1 == 0:
#	  water.amount = water.amount - 35
#	count = count - 1

func _on_Timer_timeout():
	water.amount = water.amount - 5
