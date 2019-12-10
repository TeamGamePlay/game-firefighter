extends Camera2D

onready var pos = $Position2D.position

var player

func _ready():
	pass 

func _process(delta):
	global_position = player.global_position