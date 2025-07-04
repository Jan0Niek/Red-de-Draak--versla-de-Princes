extends CharacterBody2D

class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0
@export var fireball_scene: PackedScene

@onready var mouth_node: Node2D = $Mouth

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var gravity = 998.0
var direction = 0
var game_manager

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	direction = Input.get_axis("move_left", "move_right")
	if direction:
		$Sprite2D.flip_h = -direction < 0
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	if Input.is_action_just_pressed("shoot"):
		shoot_fireball()

	move_and_slide()

func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier

	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)

func shoot_fireball():
	if fireball_scene == null:
		return

	var fireball_instance = fireball_scene.instantiate()

	fireball_instance.global_position = mouth_node.global_position

	var player_direction_vector = Vector2.RIGHT
	if $Sprite2D:
		if $Sprite2D.scale.x < 0:
			player_direction_vector = Vector2.LEFT

	fireball_instance.direction = player_direction_vector

	get_tree().current_scene.add_child(fireball_instance)
