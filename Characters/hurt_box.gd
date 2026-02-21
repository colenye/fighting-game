class_name HurtBox
extends Area2D

@export var fighter : CharacterBody2D
var playerID : int

func take_damage(dmg: int):
	if fighter:
		fighter.health -= dmg
		fighter.update_health()
