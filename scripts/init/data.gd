extends Node
var game
var server

@rpc("reliable")
func LoadMP(data:PackedByteArray) -> void:#broken data type
	var file = FileAccess.open("user://temp2",FileAccess.WRITE)
	file.store_buffer(data)
	file.close()
	file = ConfigFile.new()
	file.load("user://temp2")
	game = file.get_value("temp","game")
	server = ServerData.new()
	$/root/Main.add_child(load("res://scenes/game/game.tscn").instantiate())
	$/root/Main.move_child($/root/Main/Game,0)
	var biomes = $/root/Main/Game/World/Biomes
	for a in game.biomemap.size():
		for b in game.biomemap.size():
			biomes.set_cell(Vector2i(a,b),0,V.BIOMES[game.biomemap[a][b]])
	$/root/Main/Game.spawn_player()
	$/root/Main/Game.process_mode = Node.PROCESS_MODE_INHERIT
