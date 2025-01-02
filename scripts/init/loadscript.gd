extends Node

func _input(_event) -> void:
	if(Input.is_action_just_pressed("ui_cancel")):
		F.MainMenu()
	

func _init() -> void:
	V.SYSTEMLOG.resize(100)
	if(!DirAccess.dir_exists_absolute("user://settings")):
		DirAccess.make_dir_absolute("user://settings")
	if(!DirAccess.dir_exists_absolute("user://saves")):
		DirAccess.make_dir_absolute("user://saves")
	if(!DirAccess.dir_exists_absolute("user://saves/worlds")):
		DirAccess.make_dir_absolute("user://saves/worlds")
	S.Load("Game")
	S.Load("Controls")
	S.Load("Graphics")
	S.Load("Other")
	S.Apply()
