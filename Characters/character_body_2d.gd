class_name Fighter
extends CharacterBody2D

static var scene = preload("res://Characters/Fighter.tscn")
const SPEED := 300
const JUMP_VELOCITY = -600.0
const JABDMG := 5
const CROSSDMG := 10
var player : int

var otherPlayer : int
var health := 100
@export var hurtbox : Area2D
@export var anim : AnimationPlayer
@export var pStr : String
@export var otherPlayerCharacter : CharacterBody2D

static func init(position: Vector2, player_id: int, input_prefix: String):
	var inst = scene.instantiate()
	inst.global_position = position
	inst.player = player_id
	inst.pStr = input_prefix
	inst.hurtbox.playerID = player_id
	return inst

func set_other_player(other_player : CharacterBody2D) -> void:
	otherPlayerCharacter = other_player

# 
func face_opponent():
	if otherPlayerCharacter:
		if otherPlayerCharacter.global_position.x > global_position.x:
			
			$Sprite2D.scale.x = 1
		else:
			$Sprite2D.scale.x = -1
			
			
			
func attack():
	if Input.is_action_just_pressed(pStr + "jab"):
		anim.play("jab")
	if Input.is_action_just_pressed(pStr + "cross"):
		anim.play("cross")
func movement(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(pStr + "jump") and is_on_floor():
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
	face_opponent()
	move_and_slide()

# For the cross



func _on_area_2d_area_entered_jab(area: Area2D) -> void:
	if area is HurtBox and area.playerID != player:
		area.take_damage(JABDMG)


func _on_area_2d_area_entered_cross(area: Area2D) -> void:
	if area is HurtBox and area.playerID != player:
		area.take_damage(CROSSDMG)
