extends MultiplayerSpawner

var p1 : Fighter
var p2: Fighter
@export var UI: Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	
	multiplayer.peer_connected.connect(spawn_player)


func spawn_player():
	if !multiplayer.is_server(): return
	
	
	p1 = Luffy.init(Vector2(50,50), 1, "p1_")
	
	
	p1.signal_stats.connect(UI.update_p1_stats)

	p1.signal_death.connect(UI.death)
	
	get_node(spawn_path).call_deferred("add_child", p1)
