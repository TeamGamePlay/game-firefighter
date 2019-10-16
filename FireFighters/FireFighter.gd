extends KinematicBody2D

# generic
# movement and skills of firefighters

#signal health_changed
#signal dead

export (PackedScene) var Bullet
export (int) var speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var health

var velocity = Vector2()
var can_shoot = true
var alive = true

func _ready():
	$GunTimer.wait_time = gun_cooldown
	pass
	
func _control(delta):
	pass

func _physics_process(delta):
	if not alive:
		return
	_control(delta)
	move_and_slide(velocity)