extends Node2D

@export var conveyor_speed = 20

func _ready():
	# Set the player's dash particle speed to the conveyor speed to make it keep up with the speed of the player
	#TODO
	pass

func _physics_process(delta: float) -> void:
	# Slowly move upwards through the level at the current speed
	var positionDelta = conveyor_speed * delta
	position = Vector2(position.x, position.y - positionDelta)
