extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed

func _process(delta):
	position += velocity * delta
	

func evaporate():
	queue_free()

func _on_Area2D_body_entered(body):
	evaporate()
	if body.has_method('take_dmg'):
		body.take_dmg(damage)

func _on_Lifetime_timeout():
	evaporate()
