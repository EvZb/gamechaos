extends Node

func SetTile(layer:String,coord:Vector2i,tile:int) -> void:
	get_node(V.AREAPATH+layer).set_cell(coord,0,Vector2i(tile,0))

func SaveWorld(worldname:String,savenum:int) -> void:
	var scene = PackedScene.new()
	scene.pack($/root/Main/Game)
	D.game.scene = scene
	if(!DirAccess.dir_exists_absolute("user://saves/worlds/"+worldname)):
		DirAccess.make_dir_absolute("user://saves/worlds/"+worldname)
	var file = ConfigFile.new()
	file.set_value("Data","WorldData",D.game)
	file.save("user://saves/worlds/"+worldname+"/"+str(savenum)+".ini")
	D.game.scene = PackedScene.new()

func LoadWorld(worldname:String,savenum:int):
	var file = ConfigFile.new()
	var check = file.load("user://saves/worlds/"+worldname+"/"+str(savenum)+".ini")
	if check == OK: D.game = file.get_value("Data","WorldData")
	$/root/Main/Game.free()
	$/root/Main.add_child(D.game.scene.instantiate())
	$/root/Main.move_child($/root/Main/Game,0)
	F.MainMenu()

func MainMenu() -> void:
	if(V.MAIN_MENU_OPEN and V.GAMERUNNING):
		V.MAIN_MENU_OPEN = false
		$/root/Main/MainMenu.hide()
		$/root/Main/MainMenu.hide_menus()
		if(!V.MULTIPLAYER): $/root/Main/Game.pause(false)
		$/root/Main/Game/Player.set_physics_process(true)
	elif(V.MAIN_MENU_OPEN == false):
		$/root/Main/Game/Player.set_physics_process(false)
		if(!V.MULTIPLAYER): $/root/Main/Game.pause(true)
		V.MAIN_MENU_OPEN = true
		$/root/Main/MainMenu.show()
	$/root/Main/Console.hide()
	$/root/Main/Console.shown = false

func AddItemType(basename:String,interface:String,valuemod:int,size:int,sprite:String) -> void:
	var type = BaseType.new()
	type.Interface = interface
	type.ValueMod = valuemod
	type.Size = size
	type.Sprite = sprite
	V.ITypes.push_back(basename)
	V.IType.push_back(type)

func AddItemMat(basename:String,mass:int,element:String,affinity:int,value:int,effects:PackedStringArray) -> void:
	var mat = BaseMat.new()
	mat.Mass = mass
	mat.Element = element
	mat.Affinity = affinity
	mat.Value = value
	mat.Effects = effects
	V.IMats.push_back(basename)
	V.IMat.push_back(mat)
