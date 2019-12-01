extends Area2D


func _ready():
	pass 


func _on_AreaBombaDeAgua_player_entered(body):
	if body.get_name() == "Player":
		global._on_recharge_water()
		queue_free()