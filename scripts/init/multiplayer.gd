extends Node

var console
var players = {}
var player_info = {"name": "Default"}
var password = "password"
var timer
var pid = 1

func _ready():
	console = $/root/Main/Console
	multiplayer.peer_authentication_failed.connect(_authfail)
	multiplayer.peer_connected.connect(_connect)
	multiplayer.peer_disconnected.connect(_disconnect)
	multiplayer.connected_to_server.connect(_connectserver)
	multiplayer.connection_failed.connect(_connectfail)
	multiplayer.server_disconnected.connect(_disconnectserver)

func Join(addr:String,port:int,passwd:String) -> Error:
	multiplayer.peer_authenticating.connect(_sendauthclient)
	multiplayer.auth_callback = _authserver
	var join = ENetMultiplayerPeer.new()
	join.set_target_peer(1)
	password = passwd
	var error = join.create_client(addr,port)
	if error:
		console.Log("Failed to join game.")
		return FAILED
	multiplayer.multiplayer_peer = join
	console.Log("Joined game [%s:%s]." % [addr,str(port)])
	V.MULTIPLAYER = true
	V.GAMERUNNING = true
	$/root/Main/MainMenu/Options/Leave.hide()
	$/root/Main/MainMenu/Options/Disconnect.show()
	$/root/Main/MainMenu/Options/Start.hide()
	return OK

func Host(port:int,max_connections:int,passwd:String) -> Error:
	multiplayer.peer_authenticating.connect(_sendauthserver)
	multiplayer.server_relay = false
	multiplayer.auth_callback = _authclient
	password = passwd
	var host = ENetMultiplayerPeer.new()
	var error = host.create_server(port,max_connections)
	if error:
		console.Log("Game creation failed.")
		return FAILED
	V.MULTIPLAYER = true
	multiplayer.multiplayer_peer = host
	console.Log("Created game on port %s." % str(port))
	$/root/Main/Multiplayer/Menu/Config.hide()
	$/root/Main/Multiplayer/Menu/Servers.hide()
	$/root/Main/MainMenu/Options/Leave.hide()
	$/root/Main/MainMenu/Options/Disconnect.show()
	return OK

func Leave() -> void:
	if(V.MULTIPLAYER):
		if(pid == 1): multiplayer.peer_authenticating.disconnect(_sendauthserver)
		else: multiplayer.peer_authenticating.disconnect(_sendauthclient)
		multiplayer.multiplayer_peer = null
		V.MULTIPLAYER = false
		players.clear()
		console.Log("Disconnected from multiplayer.")
		pid = 1
	$/root/Main/Multiplayer/Menu/Config.show()
	$/root/Main/Multiplayer/Menu/Servers.show()
	$/root/Main/MainMenu/Options/Leave.show()
	$/root/Main/MainMenu/Options/Disconnect.hide()

func Load() -> void: # What happens after intitial connection
	$/root/Main/MainMenu/Options/Start.hide()
	$/root/Main/MainMenu/Options/Leave.show()

#@rpc("any_peer","reliable")
#func transfer(data:PackedByteArray, filename:String):
#	var cfile=FileAccess.open("res://file",FileAccess.WRITE )
#	cfile.store_buffer(data)
#	pass

#func transfer_file():
#	var file := FileAccess.open("res://file",FileAccess.READ)
#	print(file.get_length())
#	transfer.rpc(FileAccess.get_file_as_bytes("res://file"),"filename")
#	pass

func _sendauthclient(id:int):
	multiplayer.send_auth(id,password.to_ascii_buffer())

func _sendauthserver(id:int):
	multiplayer.send_auth(id,"server".to_ascii_buffer())

func _authclient(id:int,info:PackedByteArray):
	var passwd = info.get_string_from_ascii()
	if(passwd == password or password.is_empty()): multiplayer.complete_auth(id)
	else: multiplayer.multiplayer_peer.disconnect_peer(id)

func _authserver(id:int,data:PackedByteArray):
	if(data.get_string_from_ascii() == "server"): multiplayer.complete_auth(id)

func _authfail(id:int) -> void:
	console.Log("Authentication failed (%s)." % id)
	if(id == 1):
		Leave()
		$/root/Main/Multiplayer.show()
		$/root/Main/MainMenu/Options/Leave.hide()
		$/root/Main/MainMenu/Options/Start.show()

func _connect(id:int) -> void:
	if(id != 1):
		var file = ConfigFile.new()
		file.set_value("temp","game",D.game)
		file.save("user://temp")
		D.LoadMP.rpc_id(id, FileAccess.get_file_as_bytes("user://temp"))
		console.Log("Connected (%s)" % str(id))

func _disconnect(id:int) -> void:
	if(id != 1):
		players.erase(id)
		console.Log("Disconnected (%s)." % str(id))

func _connectserver() -> void:
	pid = multiplayer.get_unique_id()

func _connectfail() -> void:
	console.Log("Connection failed.")
	Leave()

func _disconnectserver() -> void:
	console.Log("Server disconnected.")
