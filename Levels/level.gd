class_name Level
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p1 = Fighter.init(Vector2(50,50), 1, "p1_")
	var p2 = Fighter.init(Vector2(500,50), 2, "p2_")
	p1.set_other_player(p2)
	p2.set_other_player(p1)
	add_child(p1)
	add_child(p2)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
