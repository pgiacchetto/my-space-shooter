extends Node2D

@export var conveyor_speed = 20

func _physics_process(delta: float) -> void:
	# Slowly move upwards through the level at the current speed
	var positionDelta = conveyor_speed * delta
	position = Vector2(position.x, position.y - positionDelta)
