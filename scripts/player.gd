extends CharacterBody2D
class_name Player

# Please note: The DashEffectParticle Initial Velocity needs to be set to the conveyor_speed of the player_conveyor, in order for the particle to look right.

@export var move_speed = 6000
@export var dash_speed = 18000

@onready var bullet_scene = preload("res://scenes/bullet.tscn")
var dashing: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:
	#Movement
	if dashing == false && velocity != Vector2.ZERO && Input.is_action_just_pressed("dash"):
		dashing = true
		$DashEffectParticle.emitting = true
		$DashTimer.start()
	
	if dashing:
		dash(delta)
	else:
		d_pad_movement(delta)
	

#D-Pad style movement. In prep for an alternate movement with analog stick?
func d_pad_movement(delta: float):
	var directionX = 0
	var directionY = 0
	if Input.is_action_pressed("move_left"):
		directionX -= 1
	if Input.is_action_pressed("move_right"):
		directionX += 1
	if Input.is_action_pressed("move_up"):
		directionY -= 1
	if Input.is_action_pressed("move_down"):
		directionY += 1
	
	#Get the direction vector, normalize (so that diagonals are still length 1) then multiply by move_speed and delta
	velocity = Vector2(directionX, directionY)
	velocity = velocity.normalized()
	velocity = velocity * move_speed * delta
	move_and_slide()

func shoot():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position.x = global_position.x
	bullet_instance.global_position.y = global_position.y - 6	#Slight offset to make the bullet appear it is coming out of the tip of the gun
	$BulletShooter.add_child(bullet_instance)

func die():
	queue_free()

func dash(delta: float):
	# use previous velocity but at a higher move speed
	velocity = velocity.normalized()
	velocity = velocity * dash_speed * delta
	move_and_slide()

func _on_dash_timer_timeout() -> void:
	# Player has finished his dash
	dashing = false
	$DashEffectParticle.emitting = false
