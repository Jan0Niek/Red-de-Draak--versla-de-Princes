extends CharacterBody2D

class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var gravity = 998.0
var direction = 0
var game_manager

func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		
		velocity.y = jump_power * jump_multiplier

	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else: 
		set_collision_mask_value(10, true)

func _physics_process(delta: float) -> void:
	# Voeg zwaartekracht toe als we niet op de grond zijn
	if not is_on_floor():
		velocity.y += gravity * delta
	#else:
		#velocity.y = 0.0  # Reset springval als we op de vloer zijn

	# Beweging links/rechts
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	# Beweeg de speler
	move_and_slide()
