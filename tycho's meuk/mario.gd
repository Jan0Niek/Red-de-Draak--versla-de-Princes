extends CharacterBody2D
const STD_V = 100
const GRAVITY = 200
@export var score = 0

func _physics_process(delta: float) -> void:
	velocity.y += delta * GRAVITY
	if randi() % (70 if velocity.x <= 0 else 150) == 1:
		velocity.x = STD_V if velocity.x <= 0 else (randi() % 2) * (-STD_V)
	
	if is_on_floor() and randi() % 100  == 1:
		velocity.y = -150
	move_and_slide()
	
func _init() -> void:
	velocity.x = 100




func _on_killplane_body_entered(body: Node2D) -> void:
	score += 1
	position = Vector2(0, -100)
