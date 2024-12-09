class_name World

var Areas = []
var Layers = []
var Inventories = []
var Characters = []
var Players = []

var FreeLayers:Array = []
var FreeInventories:Array = []

func AddLayer(layer:AreaLayer) -> int:
	if(FreeLayers.size() > 0):
		var layernum = FreeLayers.pop_back()
		Layers[layernum] = layer.new()
		return layernum
	else:
		Layers.push_back(layer.new())
		return Layers.size

func RemLayer(layer:int) -> void:
	Layers[layer] = null
	FreeLayers.push_back(layer)

func AddInventory(inventory:Inventory) -> int:
	if(FreeInventories.size() > 0):
		var invnum = FreeInventories.pop_back()
		Inventories[invnum] = inventory.new()
		return invnum
	else:
		Inventories.push_back(inventory.new())
		return Inventories.size

func AddCharacter(character) -> int:
	Characters.push_back(character.new())
	return Characters.size

func AddPlayer() -> int:
	Players.push_back(Player.new())
	return Players.size
