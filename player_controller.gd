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
var flipped = false
var lockedInJump = 0
const lockedInTimerTime = 120
var fireCounter = 0


func _physics_process(delta: float) -> void:
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	#direction = Input.get_axis("move_left", "move_right")
	#if direction:
		#velocity.x = direction * speed * speed_multiplier
#
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
	
	if lockedInJump != 0:
		lockedInJump -= 1
	if not is_on_floor():
		velocity.y += gravity * delta
	elif lockedInJump < (lockedInTimerTime-20):
		lockedInJump = 0

	direction = Input.get_axis("move_left", "move_right")
	#if not direction:	
		#velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
	#else:
	if lockedInJump == 0:
		velocity.x = direction * speed * speed_multiplier
	elif lockedInJump < (0.35*lockedInTimerTime) and direction:
		lockedInJump = 0
			
	if fireCounter != 0:
		fireCounter -= 1



	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		shoot_fireball()
		
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
	if event.is_action_pressed("vert") and is_on_floor():
		lockedInJump = lockedInTimerTime
		velocity.y = -800
		velocity.x = -900

	if event.is_action_pressed("move_left") and flipped == true:
		flipped = false
		scale.x = -0.4
	if event.is_action_pressed("move_right") and flipped == false:
		flipped = true
		scale.x = -0.4
	if event.is_action_pressed("vert") and is_on_floor():
		lockedInJump = lockedInTimerTime
		velocity.y = -800
		velocity.x = -900
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()

	if event.is_action_pressed("move_left") and flipped == true:
		flipped = false
		scale.x = -1
	if event.is_action_pressed("move_right") and flipped == false:
		flipped = true
		scale.x = -1
func shoot_fireball():
	if fireball_scene == null or fireCounter != 0:
		return

	var fireball_instance = fireball_scene.instantiate()
	fireball_instance.global_position = mouth_node.global_position

	var mouse_global_position = get_global_mouse_position()
	var direction_to_mouse = (mouse_global_position - fireball_instance.global_position).normalized()

	fireball_instance.direction = direction_to_mouse

	if direction_to_mouse.x > 0:
		if fireball_instance.has_node("Sprite2D"):
			fireball_instance.get_node("Sprite2D").flip_h = true

	if direction_to_mouse.y < 0:
		if fireball_instance.has_node("Sprite2D"):
			fireball_instance.get_node("Sprite2D").flip_v = true
	get_tree().current_scene.add_child(fireball_instance)
	fireCounter = 45
