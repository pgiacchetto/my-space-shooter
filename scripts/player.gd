extends CharacterBody2D
class_name Player

# Please note: The DashEffectParticle Initial Velocity needs to be set to the conveyor_speed of the player_conveyor, in order for the particle to look right.

@export var move_speed = 6000
@export var dash_speed = 18000

@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var charge_bullet_scene = preload("res://scenes/charge_bullet.tscn")
@onready var bank_right = preload("res://assets/player_bank_right.png")

@onready var animated_sprite = $AnimatedSprite2D
@onready var dash_effect_particle_r = $DashEffectParticleR
@onready var dash_effect_particle_l = $DashEffectParticleL
var dashing: bool = false
var charged: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot(bullet_scene)
		# Start the charge timer. If the player holds the shoot button over time, eventually they will be charged as indicated by this timeout
		$ChargeTimer.start()
	elif Input.is_action_just_released("shoot"):
		if charged:
			shoot(charge_bullet_scene)
			charged = false
			$ChargeParticles.setEmitting(false)
		else:
			# cancel charging
			$ChargeTimer.stop()

func _physics_process(delta: float) -> void:
	#Movement
	if !dashing:
		var dashX = 0;
		if Input.is_action_just_pressed("dash_left"):
			dashX -= 1
		if Input.is_action_just_pressed("dash_right"):
			dashX += 1
		if dashX != 0:
			dashing = true
			# Set the velocity to a unit vector of the direction we are dashing.
			# Speed will be increased when we call the dash method
			velocity = Vector2(dashX, 0)
			animated_sprite.flip_h = dashX < 0	# If this condition is true, we are banking left so we want to flip the sprite
			animated_sprite.play("bank_right")
			dash_effect_particle_r.emitting = dashX > 0
			dash_effect_particle_l.emitting = dashX < 0
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

func shoot(bullet_type):
	var bullet_instance = bullet_type.instantiate()
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
	dash_effect_particle_r.emitting = false
	dash_effect_particle_l.emitting = false
	animated_sprite.play("default")
	animated_sprite.flip_h = false


func _on_charge_timer_timeout() -> void:
	charged = true
	$ChargeParticles.setEmitting(true)
