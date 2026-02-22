extends Control

@onready var p1HealthBar := $p1HealthBar
@onready var p1StaminaBar := $p1StaminaBar
@onready var p2HealthBar := $p2HealthBar
@onready var p2StaminaBar := $p2StaminaBar


func update_p1_stats(health, stamina):
	p1HealthBar.value = health
	p1StaminaBar.value = stamina
func update_p2_stats(health, stamina):
	p2HealthBar.value = health
	p2StaminaBar.value = stamina
