class_name fighter
extends CharacterBody2D

static var scene = preload("res://Characters/Fighter.tscn")
const SPEED := 50
const JUMP_VELOCITY = -400.0
var player : int

static func init(position := [50,50], player := 1):
	var inst = scene.instantiate()
	inst.global_position.x = position[0]
	inst.global_position.y = position[1]
	inst.player = player
	return inst

func attack():
	var f = Input.is_key_pressed(KEY_F)
	print(f)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := 0
	if player == 1:
		direction = Input.get_axis("p1_left", "p1_right")
	else:
		direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	attack()
	move_and_slide()
