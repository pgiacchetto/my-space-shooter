extends Area2D



func _on_body_entered(body: Node) -> void:
	if body is Player:
		#TODO collide with the asteroid
		body.die()
		explode()

func explode():
	#TODO explosion animation?
	queue_free()
