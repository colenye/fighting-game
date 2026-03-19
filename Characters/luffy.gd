class_name Luffy
extends Fighter


# Preload the child scene

static func init(position: Vector2, player_id: int, input_prefix: String):
	var scene = preload("uid://5i055ky8lkpj")
	var f = Fighter.init_parent(position, player_id, input_prefix, scene)
	f.SPEED = 300
	f.JUMP_VELOCITY = -400
	f.JABDMG = 5
	f.CROSSDMG = 10
	f.MAXHEALTH = 100
	f.MAXSTAMINA = 1000
	f.DASH = 1500
	return f

func special():
	anim.play("Luffy/special")
