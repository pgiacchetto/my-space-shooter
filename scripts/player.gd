extends CharacterBody2D

@export var move_speed = 4000

func _physics_process(delta: float) -> void:
	#Movement
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
	
	velocity = Vector2(directionX * move_speed * delta, directionY * move_speed * delta)
	move_and_slide()
