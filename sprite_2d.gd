extends AnimatedSprite2D


func _on_axe_area_body_entered(body: Node2D) -> void:
	if body.name == "Mario":
		frame = 1
