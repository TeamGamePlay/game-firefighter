extends "res://FireFighters/FireFighter.gd"

onready var gameOver = preload("res://GameOver.tscn")

onready var ray = get_node("RayCast2D")
onready var area = get_node("AreaPlayer")

var oxigeno
var vida

func _control(delta):
	
	$Hose.look_at(get_global_mouse_position())
	var rot_dir = 0
	
	if Input.is_action_pressed("ui_right") and puedeMover:
		rot_dir += 1
	if Input.is_action_pressed("ui_left") and puedeMover:
		rot_dir -= 1
		
	rotation += rotation_speed * rot_dir * delta
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_up") and puedeMover:
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("ui_down") and puedeMover:
		velocity = Vector2(-speed/2, 0).rotated(rotation)
		
	var is_firing = Input.is_action_pressed("ui_accept")
	$Matafuego/Particles2D.emitting = is_firing
	$Matafuego/Area2D/CollisionPolygon2D.disabled = not is_firing
	if is_firing:
		global._on_water()
		print("Aguaaaa!!!")

func _on_GunTimer_timeout():
	can_shoot = true

func quitaOxigeno(actOx):
	if(oxigeno == 0):
		oxigeno = 0
	else:
		oxigeno = actOx
	
func quitaVida(actVida):
	vida = actVida
	
func _on_EnvTimer_timeout():
	var areas = area.get_overlapping_areas()
	for area in areas:
		if area.get_name() == "Humo":
			# toma los valores de los coleres que tiene actualmente
			var r = $CaraBombero.get_modulate().r
			var g = $CaraBombero.get_modulate().g - 0.15
			var b = $CaraBombero.get_modulate().b
			print(g)
			global._on_smoke()
			if(oxigeno <= 0):
				# se pone azul cuando se queda sin oxigeno
				$CaraBombero.set_modulate(Color( 0, 0, 0.55, 1 ))
				puedeMover = false
				var newGameOver = gameOver.instance()
				get_parent().add_child(newGameOver)
			else:
				$CaraBombero.set_modulate(Color(r,g,b))
			print("Pierdo oxigeno!")
			

func _on_EnvTimer2_timeout():
	var areas = area.get_overlapping_areas()
	for area in areas:
		if area.get_name() == "Fuego":
			# toma los valores de los coleres que tiene actualmente
			var r2 = $CaraBombero.get_modulate().r
			var g2 = $CaraBombero.get_modulate().g - 0.15
			var b2 = $CaraBombero.get_modulate().b
			global._on_fire()
			if(vida <= 0):
				$CaraBombero.set_modulate(Color(131, 52, 157, 255))
				puedeMover = false
				var newGameOver = gameOver.instance()
				get_parent().add_child(newGameOver)
				# Se pone morado cuando se queda sin vida
			else:
				$CaraBombero.set_modulate(Color(r2,g2,b2))
			print("me quemo mabel!!!")
