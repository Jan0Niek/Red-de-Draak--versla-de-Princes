extends CharacterBody2D
const JUMP_HEIGHT = 300
const STANDARD_V = 200
const GRAVITY = 300
@export var score = 0

func _physics_process(delta: float) -> void:
	velocity.y += delta * GRAVITY
	if randi() % (40 if velocity.x <= 0 else 150) == 1:
		velocity.x = STANDARD_V if velocity.x <= 0 or position.x < -400 else (randi() % 2) * (-STANDARD_V)
	if is_on_floor() and randi() % 40  == 1:
		velocity.y = -JUMP_HEIGHT
	move_and_slide()
	
func _init() -> void:
	velocity.x = STANDARD_V
	position = Vector2(0, -100)

func _on_kill_plane_body_entered(body: Node2D) -> void:
	score += 1
	position = Vector2(-1050, -30)
	$"../Camera2D/Control/score".text = str(score)
