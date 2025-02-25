extends CanvasLayer

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
	V.MULTIPLAYER = true
	console.Log("Joined game [%s:%s]." % [addr,str(port)])
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
	multiplayer.multiplayer_peer = host
	console.Log("Created game on port %s." % str(port))
	$Menu/Config.hide()
	$Menu/Servers.hide()
	$/root/Main/MainMenu/Options/Leave.hide()
	$/root/Main/MainMenu/Options/Disconnect.show()
	return OK

func Leave() -> void:
	if(pid == 1): multiplayer.peer_authenticating.disconnect(_sendauthserver)
	else: multiplayer.peer_authenticating.disconnect(_sendauthclient)
	players.clear()
	$Menu/Config.show()
	$Menu/Servers.show()
	multiplayer.multiplayer_peer = null
	V.MULTIPLAYER = false
	pid = 1
	console.Log("Disconnected from multiplayer.")

func Load() -> void: # What happens after intitial connection
	$/root/Main/MainMenu/Options/Start.hide()
	$/root/Main/MainMenu/Options/Leave.show()

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
	console.Log("Authentication failed." % id)

func _connect(id:int) -> void:
	if(id != 1):
		console.Log("Connected (%s)" % str(id))

func _disconnect(id:int) -> void:
	if(id != 1):
		players.erase(id)
		console.Log("Disconnected (%s)." % str(id))

func _connectserver() -> void:
	pid = multiplayer.get_unique_id()

func _connectfail() -> void:
	multiplayer.multiplayer_peer = null
	console.Log("Connection failed.")

func _disconnectserver() -> void:
	console.Log("Server disconnected.")
	Leave()

func _on_save_pressed() -> void:pass

func _on_join_pressed() -> void:
	if(Join($Menu/Config/Info/IP.text,int($Menu/Config/Info/Port.text),$Menu/Config/Info/Password.text)):pass#fail
	else:pass#success

func _on_start_pressed() -> void:
	var mp = int($Menu/Config/Create/MaxPlayers.text)
	var port = int($Menu/Config/Create/Port.text)
	if(port == clampi(port,1024,65535)):
		if(mp == clampi(mp,0,4095)):
			if(Host(port,mp,$Menu/Config/Create/Password.text)): return#creation failed
			else: return#game created
		else: return
	else: return

func _on_back_pressed() -> void:
	V.MAIN_MENU_OPEN = true
	$/root/Main/MainMenu.show()
	hide()
