extends CharacterBody2D
class_name Player

@export var move_speed = 6000

func _physics_process(delta: float) -> void:
	#Movement
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

func die():
	queue_free()
