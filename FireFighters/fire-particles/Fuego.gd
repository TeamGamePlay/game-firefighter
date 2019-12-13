extends Node2D

func _ready():
	$AnimationPlayer.play("llamas")


func _on_Fuego_area_entered(area):
	if area.get_name() == "Area2D":
		global.apagar_fuego(self)