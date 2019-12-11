extends KinematicBody2D

onready var gameOver = preload("res://Label/GameOver.tscn")

onready var ray = get_node("RayCast2D")
onready var area = get_node("AreaPlayer")
signal shoot

export (PackedScene) var Water
export (int) var speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var health
export(int) var vision_range = 5

var velocity = Vector2()
var can_shoot = true
var alive = true
var oxigeno
var vida = 1000

enum STATE {
	RUN,
	IDLE,
	# GETTING_DAMAGE
	#
	DEAD
}

var next_state = STATE.IDLE
var state = STATE.IDLE

var input

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 200
	_change_state()
	pass # Replace with function body.

func presiono():
	input = {
		movUp = Input.is_action_pressed("arriba"),
		movDown = Input.is_action_pressed("abajo"),  
		movLeft = Input.is_action_pressed("derecha"),
		movRight = Input.is_action_pressed("izquierda")
		}

func _physics_process(delta):
	if next_state != state:
		_change_state()
		
	_run_state()

func _change_state():
	# Limpio el state viejo
	match state:
		STATE.RUN:
			state = next_state
		STATE.IDLE:
			state = next_state
		STATE.DEAD:
			state = next_state
			
	# Inicializo el state nuevo
	match next_state:
		STATE.RUN:
			$AnimationPlayer.play("caminar")
		STATE.IDLE:
			$AnimationPlayer.play("idle")
		STATE.DEAD:
			$CuerpoBombero2.visible = false
			$CaraBombero2.visible = true
		

func _run_state():
	match state:
		STATE.RUN:
			_mover()
		STATE.IDLE:
			_idle()
		STATE.DEAD:
			_dead()
			
func _dead():
	get_parent().gameOver()
	
func _idle():
	disparar()
	rotar()
	presiono()
	if(input.movUp or input.movDown or input.movLeft or input.movRight):
		next_state = STATE.RUN
		
func rotar():
	self.look_at(get_global_mouse_position())

func _mover():
	rotar()
	
	rotation += rotation_speed 
	velocity = Vector2()
	
	presiono()
	if(input.movUp or input.movDown or input.movLeft or input.movRight):
		mover()
	else:
		next_state = STATE.IDLE
	
	disparar()
	
#		print("Aguaaaa!!!")

func mover():
	if input.movRight and get_local_mouse_position().length() >= vision_range:
		velocity = Vector2(0, speed).rotated(rotation)
	
	if input.movLeft and get_local_mouse_position().length() >= vision_range:
		velocity = Vector2(0, -speed/2).rotated(rotation)
	
	if input.movUp and get_local_mouse_position().length() >= vision_range:
		velocity = Vector2(speed, 0).rotated(rotation)
	
	if input.movDown and get_local_mouse_position().length() >= vision_range:
		velocity = Vector2(-speed/2, 0).rotated(rotation)
	
	move_and_slide(velocity)
	
func disparar():
	var is_firing = Input.is_action_pressed("ui_accept")
	$Matafuego/Particles2D.emitting = is_firing
	$Matafuego/Area2D/CollisionPolygon2D.disabled = not is_firing
	$sonido/AudioStreamPlayer.playing = is_firing
	if is_firing:
		global._on_water()

func desactivarMatafuego():
	$Matafuego/Particles2D.emitting = false
	$Matafuego/Area2D/CollisionPolygon2D.disabled = true
	
func colocarMascara():
	$sonido/tomar_item.playing = true
	$mascara.region_enabled = false
	
func sonidoDeAgua():
	$sonido/tomar_item.playing = true
	
func colocarLlave():
	$sonido/tomar_llave.playing = true
	$llave.region_enabled = false

func _on_GunTimer_timeout():
	can_shoot = true
	
func tieneMascara():
	return ! $mascara.region_enabled
	
func tieneLlave():
	$sonido/abrir_puerta.playing = true
	return ! $llave.region_enabled
	
func quitaOxigeno(actOx):
	if(oxigeno == 0):
		oxigeno = 0
	else:
		oxigeno = actOx
		
func restablecerOxigeno():
	oxigeno = 2000
	
func quitaVida(actVida):
	vida = actVida
	
func _on_EnvTimer_timeout():
	var areas = area.get_overlapping_areas()
	for area in areas:
		if area.get_name() == "Fuego":
			# toma los valores de los coleres que tiene actualmente
			var r2 = $CaraBombero.get_modulate().r
			var g2 = $CaraBombero.get_modulate().g - 0.15
			var b2 = $CaraBombero.get_modulate().b
			global._on_fire()
			global._on_fire2()
			global._on_smoke()
			if(vida <= 0 or oxigeno <= 0):
				if ! self.tieneMascara():
					next_state = STATE.DEAD
					$sonido/game_over.playing = true
				# Se pone morado cuando se queda sin vida
				else:
					$mascara.region_enabled = true
					global._on_info_out()
					global._on_recharge_oxigeno()
			else:
				$CaraBombero.set_modulate(Color(r2,g2,b2))
			

func _on_EnvTimer2_timeout():
	pass
