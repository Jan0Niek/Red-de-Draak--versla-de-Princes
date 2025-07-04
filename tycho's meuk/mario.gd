extends CharacterBody2D
const JUMP_HEIGHT = 1000
const GRAVITY = 1300
var STANDARD_V = 200
@export var iFrames = 0
@export var power = 1
@export var score = 0

func _physics_process(delta: float) -> void:
	velocity.y += delta * GRAVITY
	
	if randi() % (40 if velocity.x <= 0 else 150) == 1:
		velocity.x = STANDARD_V if velocity.x <= 0 or position.x < -400    else (randi() % 2) * (-STANDARD_V)
	if is_on_floor() and randi() % 40  == 1:
		velocity.y = -JUMP_HEIGHT
	move_and_slide()
	

func _process(delta: float) -> void:
	print(iFrames)
	if not is_on_floor():
		$Sprite2D.frame = 2 + power * 3
	elif velocity.x == 0:
		$Sprite2D.frame = 0 + power * 3
	else:
		$Sprite2D.frame = 1 + power * 3
	
	if iFrames != 0:
		iFrames -= 1

func _init() -> void:
	velocity.x = STANDARD_V
	position = Vector2(0, -100)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if power == 0 and iFrames == 0:
		score += 1
		position = Vector2(-1050, -30)
		$"../Camera2D/Control/score".text = str(score)
		power = 1 if score <= 5 else  (1 + (randi() % 2) if score <= 10 else 2)
		STANDARD_V = 200 + score * 20
	elif iFrames == 0: 
		power -= 1
		iFrames = 60
