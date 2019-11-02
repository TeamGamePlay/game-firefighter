extends "res://FireFighters/FireFighter.gd"

onready var ray = get_node("RayCast2D")

func _control(delta):
	
	$Hose.look_at(get_global_mouse_position())
	var rot_dir = 0
	
	if Input.is_action_pressed("ui_right"):
		rot_dir += 1
	if Input.is_action_pressed("ui_left"):
		rot_dir -= 1
		
	rotation += rotation_speed * rot_dir * delta
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(-speed/2, 0).rotated(rotation)
		
	var is_firing = Input.is_action_pressed("ui_accept")
	$Particles2D.emitting = is_firing
	$Area2D/CollisionPolygon2D.disabled = not is_firing

func _on_GunTimer_timeout():
	can_shoot = true
