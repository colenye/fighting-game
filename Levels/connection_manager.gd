class_name ConnectionManager
extends Node


func create_server() -> void:
	var peer = ENetMultiplayerPeer.new()
	var res = peer.create_server(42069)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(
		func(peer_id: int) -> void:
			print("connected" + str(peer_id))
	)
	multiplayer.peer_disconnected.connect(
		func(peer_id: int) -> void:
			print("disconnected: " + str(peer_id))
	)
func join_server() -> void:
	var peer = ENetMultiplayerPeer.new()
	var res = peer.create_client("localhost", 42069)
	multiplayer.multiplayer_peer = peer


func _on_server_button_pressed() -> void:
	create_server()


func _on_client_button_pressed() -> void:
	join_server()
