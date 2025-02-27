extends Area2D

@export var hit_points: int = 3

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
