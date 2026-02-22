class_name Fighter
extends CharacterBody2D

# NOTE: Fighter is never to be instantiated, it is the blueprint/parent class of all fighters

# Emit these signals whenever health and stamina change so that the UI in Level can update
signal signal_stats(health: int, stamina: float)

# These values will be set by children that inherit Fighter (the values in caps)
var SPEED : int
var JUMP_VELOCITY : int
var JABDMG : int
var CROSSDMG : int
var DASH : int
var MAXHEALTH : int
var MAXSTAMINA : int
var STAMINAREGENRATE : int

var player : int
var otherPlayer : int
var dashing : bool
var _currHealth : int

var currHealth : int:
	get:
		return _currHealth
	set(value):
		var clamped = clamp(value, 0, MAXHEALTH)
		_currHealth = clamped
		emit_signal("signal_stats", _currHealth, _currStamina)

var _currStamina : float = 0.0

var currStamina : float:
	get:
		return _currStamina
	set(value):
		var old_value = _currStamina
		_currStamina = clamp(value, 0.0, MAXSTAMINA)

		if _currStamina < old_value:
			staminaDelayTimer.start()
			
		emit_signal("signal_stats", _currHealth, _currStamina)

@onready var timer := $DashTimer
@onready var staminaDelayTimer := $StaminaDelayTimer
@export var hurtbox : Area2D
@export var anim : AnimationPlayer
@export var pStr : String
@export var playerCharacter : CharacterBody2D
@export var otherPlayerCharacter : CharacterBody2D

static func init_parent(position: Vector2, player_id: int, input_prefix: String, scene: PackedScene):
	var inst = scene.instantiate()
	inst.global_position = position
	inst.player = player_id
	inst.pStr = input_prefix
	inst.hurtbox.playerID = player_id
	return inst

func _ready() -> void:
	currHealth = MAXHEALTH
	currStamina = MAXSTAMINA

func _physics_process(delta: float) -> void:

	move_and_slide()
	face_opponent()
	regen_stamina(delta)
	
	if currStamina > 0:
		attack()
		dash()
		if not dashing:
			movement(delta)

func regen_stamina(delta):
	if staminaDelayTimer.is_stopped() and currStamina < MAXSTAMINA:
		currStamina += 20 * delta

func dash():
	if Input.is_action_just_pressed(pStr + "dash"):
		timer.start()
		dashing = true
		velocity.x = DASH
		currStamina -= 25
		
func attack():
	if Input.is_action_just_pressed(pStr + "jab") and currStamina > 0:
		anim.play("jab")
		currStamina -= 10
	if Input.is_action_just_pressed(pStr + "cross"):
		anim.play("cross")
		currStamina -= 20
	if Input.is_action_just_pressed(pStr + "special"):
		special()

# Called in the level script
func set_other_player(other_player : CharacterBody2D) -> void:
	otherPlayerCharacter = other_player

func face_opponent():
	if otherPlayerCharacter:
		if otherPlayerCharacter.global_position.x > global_position.x:
			$Sprite2D.scale.x = 1
		else:
			$Sprite2D.scale.x = -1

# TO BE OVERRIDEN BY CHILD
func special():
	pass

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

# Eventually add currHealth bars and it'll update the currHealth bar
func update_health() -> void:
	if currHealth < 90:
		pass

func _on_area_2d_area_entered_jab(area: Area2D) -> void:
	if area is HurtBox and area.playerID != player:
		area.take_damage(JABDMG)

func _on_area_2d_area_entered_cross(area: Area2D) -> void:
	if area is HurtBox and area.playerID != player:
		area.take_damage(CROSSDMG)

# For the dash
func _on_timer_timeout() -> void:
	dashing = false
