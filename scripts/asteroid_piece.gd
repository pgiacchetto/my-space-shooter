extends Area2D

@export var hit_points: int = 3
@export var speed = 20
var velocity = Vector2.ZERO

func _ready():
	var randomAnimation = randi() % 3
	if randomAnimation == 0:
		$AnimationPlayer.play("rotation_1")
	elif randomAnimation == 1:
		$AnimationPlayer.play("rotation_2")
	elif randomAnimation == 2:
		$AnimationPlayer.play("rotation_3")
	
	var randomAngle = (randi() % 8) * 45
	velocity = Vector2.from_angle(randomAngle) * speed

func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_body_entered(body: Node) -> void:
	if body is Player:
		#TODO collide with the asteroid
		body.die()
		explode()

func take_damage(damage_points: int):
	hit_points -= damage_points
	if hit_points > 0:
		$TakeDamageAnimation.play("take_damage")
	else:
		explode()
		
func explode():
	# For now, just delete. But I am thinking in the future, we play some explosion that throws bits in three random directions
	queue_free()
