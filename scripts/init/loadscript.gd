extends Node

func _input(_event) -> void:
	if(Input.is_action_just_pressed("ui_cancel")):
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
	

func _init() -> void:
	V.SYSTEMLOG.resize(100)
	if(!DirAccess.dir_exists_absolute("user://settings")):
		DirAccess.make_dir_absolute("user://settings")
		print("Create settings folder")
	if(!DirAccess.dir_exists_absolute("user://saves")):
		DirAccess.make_dir_absolute("user://saves")
		print("Create saves folder")
	S.Load("Game")
	S.Load("Controls")
	S.Load("Graphics")
	S.Load("Other")
	S.Apply()
