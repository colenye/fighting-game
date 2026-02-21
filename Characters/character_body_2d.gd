class_name Fighter
extends CharacterBody2D

static var scene = preload("res://Characters/Fighter.tscn")
const SPEED := 50
const JUMP_VELOCITY = -400.0
const JABDMG := 5
const CROSSDMG := 10
var player : int
var pStr : String
var otherPlayer : int
var health := 100
@export var hurtbox : Area2D
@export var anim : AnimationPlayer

static func init(position := [50,50], player := 1):
	var inst = scene.instantiate()
	inst.global_position.x = position[0]
	inst.global_position.y = position[1]
	inst.player = player
	inst.otherPlayer = 3 - player
	inst.pStr = "p" + str(player) + "_"
	inst.hurtbox.playerID = player
	return inst

func attack():
	if Input.is_action_just_pressed(pStr + "jab"):
		anim.play("jab")
	if Input.is_action_just_pressed(pStr + "cross"):
		anim.play(pStr + "cross")
func movement(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction = Input.get_axis(pStr + "left", pStr + "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
# Eventually add health bars and it'll update the health bar
func update_health() -> void:
	if health < 90:
		print("gg")

func _physics_process(delta: float) -> void:
	
	movement(delta)
	attack()
	move_and_slide()

# For the cross
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is HurtBox and area.playerID != player:
		area.take_damage(CROSSDMG)
