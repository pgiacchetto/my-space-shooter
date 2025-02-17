extends Area2D



func _on_body_entered(body: Node2D) -> void:
	vacuum(body)

func _on_area_entered(area: Area2D) -> void:
	vacuum(area)

func vacuum(node: Node):
	# Anything that enters the vacuum is deleted. Cleans up objects as we scroll
	node.queue_free()
