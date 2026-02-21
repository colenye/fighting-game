extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p1 = fighter.init([50,50], 1)
	var p2 = fighter.init([500,50], 2)
	add_child(p1)
	add_child(p2)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
