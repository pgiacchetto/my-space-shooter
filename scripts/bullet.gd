extends Area2D

@export var move_speed = 180
@export var damage_points = 1

func _physics_process(delta: float) -> void:
	#So far, simple movement upwards. Maybe different bullets have different effects
	global_position.y -= move_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Destroy bullet when it leaves the screen (no longer useful)
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shootable"):
		area.take_damage(damage_points)
		queue_free()
