extends Node

var biome:Array[Vector2i] = []
var biomeshuffle:Array[Vector2i] = []
var biomecount:int = V.BIOMES.size()
var tiles:Node
var maxsize:int
var settings:Dictionary

func Set(coord:Vector2i,tile:Vector2i) -> void:
	tiles.set_cell(coord,0,tile)

func Generate() -> void:
	maxsize = S.Worldgen["Size"]
	$/root/Main.add_child(load("res://scenes/game/game.tscn").instantiate())
	$/root/Main.move_child($/root/Main/Game,0)
	D.game = GameData.new()
	D.server = ServerData.new()
	GenerateBiomes()
	GenerateAreas()
	$/root/Main/MainMenu/Options/Start.hide()
	$/root/Main/MainMenu/Options/Leave.show()
	$/root/Main/Multiplayer/Menu/Config/Info.hide()
	$/root/Main/Multiplayer/Menu/Config/Create.show()
	$/root/Main/Game.add_child(load("res://scenes/game/player.tscn").instantiate())
	$/root/Main/Game.process_mode = Node.PROCESS_MODE_INHERIT

func GenerateBiomes() -> void:
	D.game.world.Size = maxsize
	tiles = get_node(V.WORLDPATH + "Biomes")
	var maxsize1:int = maxsize - 1
	D.game.biomemap.clear()
	D.game.biomemap.resize(maxsize)
	var arrr:PackedStringArray
	arrr.resize(maxsize)
	D.game.biomemap.fill(arrr)
	D.game.areamap = D.game.biomemap.duplicate(true)
	var unit:int = maxsize / (sqrt(biomecount))
	var biomeloc:Vector2i
	var biomewidth:int
	var currentbiome:Vector2i
	var currentheight:int = 0
	var biomenum:int
	var biomename:String
	var coord:Vector2i
	biomeshuffle = V.BIOMES.values()
	for i in biomecount: biome.push_back(biomeshuffle.pop_at(randi()%biomeshuffle.size()))
	for c in maxsize / biomecount:
		for b in maxsize/biomecount:
			biomewidth = (randi()%unit+unit) / 2
			biomeloc = Vector2i(randi()%maxsize,randi()%maxsize)
			biomenum = randi()%biomecount
			currentbiome = biome[biomenum]
			biomename = V.BIOMES.keys()[biomenum]
			currentheight = 0
			Set(biomeloc,currentbiome)
			#generate left side of biome
			for n in biomewidth:
				currentheight += randi()%2
				for tile in currentheight:
					coord = Vector2i(biomeloc.x + n - biomewidth,biomeloc.y - tile).clampi(0,maxsize1)
					Set(coord,currentbiome)
					D.game.biomemap[coord.x][coord.y] = biomename
					coord.y = mini(biomeloc.y + tile,maxsize1)
					Set(coord,currentbiome)
					D.game.biomemap[coord.x][coord.y] = biomename
			#generate right side of biome
			for n in biomewidth:
				currentheight -= randi()%2
				for tile in currentheight:
					coord = Vector2i(biomeloc.x + n,biomeloc.y - tile).clampi(0,maxsize1)
					Set(coord,currentbiome)
					D.game.biomemap[coord.x][coord.y] = biomename
					coord.y = mini(biomeloc.y + tile,maxsize1)
					Set(coord,currentbiome)
					D.game.biomemap[coord.x][coord.y] = biomename

func GenerateAreas() -> void:
	tiles = get_node(V.WORLDPATH + "Areas")
	tiles.clear()
	var pos:int
	var towns:Array[int]
	var town:Vector2i
	var selection:int
	var area:String
	var sett:int
	var path:Vector2i
	var num:int
	towns.resize(maxsize/2)
	for x in maxsize/2:#generate towns
		pos = randi()%maxsize
		towns[x] = pos
		D.game.areamap[x*2][pos] = "Town"
		Set(Vector2i(x*2,pos),Vector2i(4,1))
	for t in towns.size():#generate pathes between towns
		selection = randi()%towns.size()
		sett = t * 2
		town = Vector2i(towns[t],towns[selection])
		path = Vector2i((selection - t) * 2,towns[selection] - towns[t])
		#check if there is already a nearby path
		for c in 10:
			if(D.game.areamap[sett][mini(town.x + c,maxsize -1)] == "Path"): path = Vector2i(0,c); break
			if(D.game.areamap[sett][maxi(town.x - c,0)] == "Path"): path = Vector2i(0,-c); break
			if(D.game.areamap[mini(sett + c,maxsize -1)][town.y] == "Path"): path = Vector2i(c,0); break
			if(D.game.areamap[maxi(sett - c,0)][town.y] == "Path"): path = Vector2i(-c,0); break
		for p in absi(path.y):#generate vetical path
			num = (p + 1) * clampi(path.y,-1,1)
			area = D.game.areamap[sett][town.x + num]
			if(area == "Path"):
				Set(Vector2i(sett,town.x + num),Vector2i(2,1))
				D.game.areamap[sett][town.x + num] = "Path"
				break
			elif(area == ""):
				Set(Vector2i(sett,town.x + num),Vector2i(0,1))
				D.game.areamap[sett][town.x + num] = "Path"
			else: break
		for p in absi(path.x):#generate horizontal path
			num = p * clampi(path.x,-1,1)
			area = D.game.areamap[sett + num][town.y]
			if(area == "Path"):
				Set(Vector2i(sett + num,town.y),Vector2i(2,1))
				D.game.areamap[sett + num][town.y] = "Path"
				if(p != 0):break
			elif(area == ""):
				Set(Vector2i(sett + num,town.y),Vector2i(1,1))
				D.game.areamap[sett + num][town.y] = "Path"
			else: break
