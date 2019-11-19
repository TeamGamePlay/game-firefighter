extends KinematicBody2D

# generic
# movement and skills of firefighters

#signal health_changed
#signal dead
signal shoot

export (PackedScene) var Water
export (int) var speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var health

var velocity = Vector2()
var can_shoot = true
var alive = true

var puedeMover

func _ready():
	$GunTimer.wait_time = gun_cooldown
	puedeMover = true
	
func _control(delta):
	pass

func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2.RIGHT.rotated($Hose.global_rotation)
		emit_signal('shoot', Water, $Hose/Muzzle.global_position, dir)

func _physics_process(delta):
	if not alive:
		return
	_control(delta)
	move_and_slide(velocity)
	
