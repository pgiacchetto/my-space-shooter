extends Area2D

@export var hit_points: int = 3
@onready var asteroidPieceScene = preload("res://scenes/asteroid_piece.tscn")

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
	# spawn 3 asteroid pieces
	var asteroidPiece1 = asteroidPieceScene.instantiate()
	var asteroidPiece2 = asteroidPieceScene.instantiate()
	var asteroidPiece3 = asteroidPieceScene.instantiate()
	asteroidPiece1.global_position = global_position
	asteroidPiece2.global_position = global_position
	asteroidPiece3.global_position = global_position
	add_sibling(asteroidPiece1)
	add_sibling(asteroidPiece2)
	add_sibling(asteroidPiece3)
	queue_free()
