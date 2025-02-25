extends Node

# These signals can be connected to by a UI lobby scene or the game scene.
signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected

var console
# This will contain player info with the keys being each player's unique IDs.
var players = {}

# This is the local player info. This should be modified locally
# before the connection is made. It will be passed to every other peer.
# For example, the value of "name" can be set to something the player
# entered in a UI scene.
var player_info = {"name": "Name"}
var players_loaded = 0

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	console = $/root/Main/Console

func join_game(addr:String,port:int):
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(addr,port)
	if error:
		console.Log("Failed to join game.")
		return
	multiplayer.multiplayer_peer = peer
	console.Log("Joined game [%s:%s]." % [addr,str(port)])

func create_game(port:int,max_connections:int):
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port,max_connections)
	if error:
		console.Log("Game creation failed.")
		return
	multiplayer.multiplayer_peer = peer
	console.Log("Created game on port %s." % str(port))
	players[1] = player_info
	player_connected.emit(1, player_info)

func remove_multiplayer_peer():
	multiplayer.multiplayer_peer = null
	console.Log("Disconnected from multiplayer.")
# When the server decides to start the game from a UI scene,
# do Lobby.load_game.rpc(filepath)
@rpc("call_local", "reliable")
func load_game(_scene):
	console.Log("Load game scene.")
	#get_tree().change_scene_to_file(game_scene_path)

# Every peer will call this when they have loaded the game scene.
@rpc("any_peer", "call_local", "reliable")
func player_loaded():
	if multiplayer.is_server():
		players_loaded += 1
		if players_loaded == players.size():
			#$/root/Game.start_game()
			players_loaded = 0

# When a peer connects, send them my player info.
# This allows transfer of all desired data for each player, not only the unique ID.
func _on_player_connected(id):
	_register_player.rpc_id(id, player_info)
	console.Log("Player connected (%s)." % id)

@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	player_connected.emit(new_player_id, new_player_info)

func _on_player_disconnected(id):
	players.erase(id)
	player_disconnected.emit(id)
	console.Log("Player disconnected (%s)." % str(id))

func _on_connected_ok():
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	player_connected.emit(peer_id, player_info)
	console.Log("Connection success.")

func _on_connected_fail():
	multiplayer.multiplayer_peer = null
	console.Log("Connection failed.")

func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()
	console.Log("Server disconnected.")
