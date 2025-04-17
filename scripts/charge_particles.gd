extends Node2D

# Only use this value through getter and setter, or initial setting
@export var emitting: bool = false

func _ready():
	setEmitting(emitting)
	

func isEmitting() -> bool:
	return emitting

func setEmitting(emitting: bool):
	self.emitting = emitting
	self.visible = emitting
	# Go through all particles and set emitting to the boolean value
	var children = get_children()
	for child in children:
		child.emitting = emitting
