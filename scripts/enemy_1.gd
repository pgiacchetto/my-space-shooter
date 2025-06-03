extends Area2D

@export var hit_points: int = 2
@onready var enemyBulletScene = preload("res://scenes/enemy_bullet.tscn")

func _on_shoot_timer_timeout() -> void:
	# Create an enemy bullet and direct it towards the player
	var enemyBulletInstance = enemyBulletScene.instantiate()
	enemyBulletInstance.global_position = $BulletLaunchPosition.global_position
	enemyBulletInstance.direction = findUnitVectorToPlayer()
	add_sibling(enemyBulletInstance)

func findVectorToPlayer() -> Vector2:
	var vectorToPlayer = Vector2(0, 1)	# Default vector pointed downwards
	var players = get_tree().get_nodes_in_group("Player")
	if (!players.is_empty()):
		var player = players[0]
		vectorToPlayer = player.global_position - $BulletLaunchPosition.global_position
	
	return vectorToPlayer

func findUnitVectorToPlayer() -> Vector2:
	return findVectorToPlayer().normalized()

func take_damage(damage_points: int):
	hit_points -= damage_points
	if hit_points > 0:
		$TakeDamageAnimation.play("take_damage")
	else:
		queue_free()

# TODO Bug: because I toggle visibility when the enemy takes damage, this signal fires whenever that happens
func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	# Call the timeout method immediately, but also start the timer
	_on_shoot_timer_timeout()
	$ShootTimer.start()
