extends Area2D


func _ready():
	$AnimationPlayer.play("llave")


func _on_Llave_body_entered(body):
	if body.get_name() == "Player":
		body.colocarLlave()
		global._on_keys()
		#Player coloca en su cuerpo la llave.
		queue_free()
