extends Node

func SetTile(layer:String,coord:Vector2i,tile:int) -> void:
	get_node(V.LAYERPATH+layer).set_cell(coord,0,Vector2i(tile,0))

func Log(message:String,newentry:bool=true) -> void:
	if(newentry):
		if(V.LOGINDEX == 99): V.LOGINDEX = 0
		else: V.LOGINDEX += 1
		V.SYSTEMLOG[V.LOGINDEX] = message
	else:	V.SYSTEMLOG[V.LOGINDEX] += message

func SaveWorld(worldname:String,savenum:int) -> void:
	var scene = PackedScene.new()
	scene.pack($/root/Main/Game)
	V.Data.scene = scene
	if(!DirAccess.dir_exists_absolute("user://saves/worlds/"+worldname)):
		DirAccess.make_dir_absolute("user://saves/worlds/"+worldname)
	var file = ConfigFile.new()
	file.set_value("Data","WorldData",V.Data)
	file.save("user://saves/worlds/"+worldname+"/"+str(savenum)+".ini")

func LoadWorld(worldname:String,savenum:int):
	var file = ConfigFile.new()
	var check = file.load("user://saves/worlds/"+worldname+"/"+str(savenum)+".ini")
	if check == OK: V.Data = file.get_value("Data","WorldData")
	$/root/Main/Game.free()
	$/root/Main.add_child(V.Data.scene.instantiate())
	$/root/Main.move_child($/root/Main/Game,0)
	F.MainMenu()

func MainMenu() -> void:
	if(V.MAIN_MENU_OPEN):
		V.MAIN_MENU_OPEN = false
		$/root/Main/MainMenu.hide()
		$/root/Main/MainMenu.hide_menus()
		$/root/Main/Game/Player/Camera2D.enabled = true
		$/root/Main/Game.pause(false)
	else:
		$/root/Main/Game.pause(true)
		V.MAIN_MENU_OPEN = true
		$/root/Main/MainMenu.show()
		$/root/Main/Game/Player/Camera2D.enabled = false

func AddItemType(name:String,interface:String,valuemod:int,size:int,sprite:String) -> void:
	var type = BaseType.new()
	type.Interface = interface
	type.ValueMod = valuemod
	type.Size = size
	type.Sprite = sprite
	V.ITypes.push_back(name)
	V.IType.push_back(type)

func AddItemMat(name:String,mass:int,element:String,affinity:int,effects:PackedStringArray) -> void:
	var mat = BaseMat.new()
	mat.Mass = mass
	mat.Element = element
	mat.Affinity = affinity
	mat.Effects = effects
	V.IMats.push_back(name)
	V.IMat.push_back(mat)
