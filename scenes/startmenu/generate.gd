extends Control

var biome:Array[Vector2i] = []
var biomeshuffle:Array[Vector2i] = []
var biomecount:int = V.BIOMETILES.size()
var world:Node

func _ready() -> void:
	world = get_node(V.LAYERPATH + "World")

func Set(coord:Vector2i,tile:Vector2i) -> void:
	world.set_cell(coord,0,tile)

func GenerateWorld() -> void:
	var maxsize:int = 128
	var maxsize1:int = maxsize - 1
	D.biomemap.resize(maxsize)
	var arrr:PackedStringArray
	arrr.resize(maxsize)
	D.biomemap.fill(arrr)
	D.areamap = D.biomemap
	var unit:int = maxsize / sqrt(biomecount)
	var biomeloc:Vector2i
	var biomewidth:int
	var currentbiome:Vector2i
	var currentheight:int = 0
	var biomenum:int
	var biomename:String
	var coord:Vector2i
	biomeshuffle = V.BIOMETILES.duplicate()
	for i in biomecount: biome.push_back(biomeshuffle.pop_at(randi()%biomeshuffle.size()))
	for c in maxsize / biomecount:
		for b in maxsize/biomecount:
			biomewidth = (randi()%unit+unit) / 2
			biomeloc = Vector2i(randi()%maxsize,randi()%maxsize)
			biomenum = randi()%biomecount
			currentbiome = biome[biomenum]
			biomename = V.BIOMENAMES[biomenum]
			currentheight = 0
			Set(biomeloc,currentbiome)
			for n in biomewidth:
				currentheight += randi()%2
				for tile in currentheight:
					coord = Vector2i(biomeloc.x + n - biomewidth,biomeloc.y - tile).clampi(0,maxsize1)
					Set(coord,currentbiome)
					D.biomemap[coord.x][coord.y] = biomename
					coord.y = mini(biomeloc.y + tile,maxsize1)
					Set(coord,currentbiome)
					D.biomemap[coord.x][coord.y] = biomename
			for n in biomewidth:
				currentheight -= randi()%2
				for tile in currentheight:
					coord = Vector2i(biomeloc.x + n,biomeloc.y - tile).clampi(0,maxsize1)
					Set(coord,currentbiome)
					D.biomemap[coord.x][coord.y] = biomename
					coord.y = mini(biomeloc.y + tile,maxsize1)
					Set(coord,currentbiome)
					D.biomemap[coord.x][coord.y] = biomename
	print(str(D.biomemap[1][2]))
	print(str(D.biomemap[2][3]))
	print(str(D.biomemap[3][4]))
	
