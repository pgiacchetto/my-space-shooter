extends Node2D

func _process(_delta):
	#Check input
	if Input.is_action_pressed("exit"):
		#End the game
		get_tree().quit()
