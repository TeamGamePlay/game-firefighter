extends Area2D


func _ready():
	$AnimationPlayer.play("mascara")


func _on_Mascara_body_entered(body):
	if body.get_name() == "Player":
		body.colocarMascara()
		queue_free()