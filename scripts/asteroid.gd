extends Area2D

@export var hit_points: int = 3
@onready var asteroidPieceScene = preload("res://scenes/asteroid_piece.tscn")

func _on_body_entered(body: Node) -> void:
	if body is Player:
		body.die()
		call_deferred("explode")

func take_damage(damage_points: int):
	hit_points -= damage_points
	if hit_points > 0:
		$TakeDamageAnimation.play("take_damage")
	else:
		explode()
		
func explode():
	# spawn 3 asteroid pieces
	var asteroidPiece1 = asteroidPieceScene.instantiate()
	var asteroidPiece2 = asteroidPieceScene.instantiate()
	var asteroidPiece3 = asteroidPieceScene.instantiate()
	asteroidPiece1.global_position = global_position
	asteroidPiece2.global_position = global_position
	asteroidPiece3.global_position = global_position
	
	# make them go in three random *unique* directions
	var randomAngle1 = (randi() % 8) * 45
	var randomAngle2 = (randi() % 8) * 45
	while randomAngle2 == randomAngle1:
		randomAngle2 = (randi() % 8) * 45
	var randomAngle3 = (randi() % 8) * 45
	while randomAngle3 == randomAngle2 || randomAngle3 == randomAngle1:
		randomAngle3 = (randi() % 8) * 45
	
	# set velocities
	asteroidPiece1.velocity = Vector2.from_angle(randomAngle1) * asteroidPiece1.speed
	asteroidPiece2.velocity = Vector2.from_angle(randomAngle2) * asteroidPiece2.speed
	asteroidPiece3.velocity = Vector2.from_angle(randomAngle3) * asteroidPiece3.speed
	
	# add them to the scene
	add_sibling(asteroidPiece1)
	add_sibling(asteroidPiece2)
	add_sibling(asteroidPiece3)
	queue_free()
