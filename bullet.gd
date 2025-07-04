extends Area2D

var speed = 400  
var direction = Vector2.RIGHT

func _ready():
  
	set_lifetime(2)

func _physics_process(delta):

	position += direction * speed * delta

func set_lifetime(time: float):
	var timer = get_tree().create_timer(time)
	timer.timeout.connect(queue_free)

func _on_Fireball_body_entered(body):
	print("Vuurbal raakte: ", body.name)
	if body.is_in_group("Enemy"):
		body.take_damage(10) 
	queue_free() 
