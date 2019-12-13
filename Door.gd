extends Area2D


func _ready():
	pass

func _on_Door_body_entered(body):
	if body.get_name() == "Player":
		if body.tieneLlave():
			# Si el player tiene la llave, abre la puerta
			queue_free()