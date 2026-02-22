class_name Level
extends Node2D

var p1 : Fighter
var p2: Fighter
var UI: Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI = %UI
	p2 = Manny.init(Vector2(500,50), 2, "p2_")
	p1 = Luffy.init(Vector2(50,50), 1, "p1_")
	p1.set_other_player(p2)
	p2.set_other_player(p1)
	
	p1.signal_stats.connect(UI.update_p1_stats)
	p2.signal_stats.connect(UI.update_p2_stats)
	add_child(p1)
	add_child(p2)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
