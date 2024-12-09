extends Control

var biome:Array[Vector2i] = []
var biomelist:Array[Vector2i] = [Vector2i(0,0),Vector2i(1,0),Vector2i(2,0),Vector2i(3,0),Vector2i(4,0),Vector2i(5,0),Vector2i(6,0),Vector2i(7,0),Vector2i(8,0),Vector2i(9,0)]
var biomeshuffle:Array[Vector2i] = []
var biomecount:int = biomelist.size()
var world:Node

func _ready() -> void:
	world = get_node(V.LAYERPATH + "World")

func Set(coord:Vector2i,tile:Vector2i) -> void:
	world.set_cell(coord,0,tile)

func GenerateWorld() -> void:
	var maxsize:int = 128
	D.biomemap.resize(maxsize*maxsize)
	D.areamap = D.biomemap
	var unit:int = maxsize/sqrt(biomecount)
	var biomeloc:Vector2i
	var biomewidth:int
	var currentbiome:Vector2i
	var currentheight:int = 0
	biomeshuffle = biomelist.duplicate()
	for i in biomecount: biome.push_back(biomeshuffle.pop_at(randi()%biomeshuffle.size()))
	for c in maxsize/biomecount:
		for b in maxsize/biomecount:
			biomewidth = (randi()%unit+unit)/2
			biomeloc = Vector2i(randi()%maxsize,randi()%maxsize)
			currentbiome = biome[randi()%biomecount]
			currentheight = 0
			Set(biomeloc,currentbiome)
			for n in biomewidth:
				currentheight += randi()%2
				for tile in currentheight:
					Set(Vector2i(biomeloc.x+n-biomewidth,biomeloc.y + tile),currentbiome)
					Set(Vector2i(biomeloc.x+n-biomewidth,biomeloc.y - tile),currentbiome)
			for n in biomewidth:
				currentheight -= randi()%2
				for tile in currentheight:
					Set(Vector2i(biomeloc.x+n,biomeloc.y + tile),currentbiome)
					Set(Vector2i(biomeloc.x+n,biomeloc.y - tile),currentbiome)
	for n in D.biomemap.size():
		D.biomemap[n] = world.get_cell_atlas_coords(Vector2i(n/maxsize,n%maxsize))
