extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_body_entered(body):
	print("ding raakte axe!!!")
	#get_parent().get_parent().get_node("player").velocity.y -= 10




func _on_area_entered(area):
	print("oaishdiasuh")
	



func _on_mouse_entered():
	print("mous wel!!")
