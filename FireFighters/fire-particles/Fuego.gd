extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("llamas")


func _on_Fuego_area_entered(area):
	if area.get_name() == "Area2D":
		global.apagar_fuego(self)
	#	global._on_smoke()