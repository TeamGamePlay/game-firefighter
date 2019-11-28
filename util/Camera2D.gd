extends Camera2D

onready var pos = $Position2D.position

var player

func _ready():
	pass 

func _process(delta):
	global_position = player.global_position#Vector2(max(global_position.x, player.global_position.x), max(global_position.y, player.global_position.y))