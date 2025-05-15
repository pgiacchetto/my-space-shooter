extends Area2D

@export var move_speed = 90
@export var direction = Vector2(0, 1)	#Unit vector for direction

func _physics_process(delta: float) -> void:
	global_position += direction * move_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Destroy bullet when it leaves the screen (no longer useful)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
		queue_free()
