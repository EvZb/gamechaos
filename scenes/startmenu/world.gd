extends Control

var settings

func _ready() -> void: settings = S.Load("Worldgen")

func _on_wsize_changed() -> void: settings["Size"] = int($WSize.value)

func _on_finish_pressed() -> void:
	hide()
	S.Worldgen = settings
	S.Save("Worldgen", settings)
	$/root/Main/StartMenu/Generate.Generate()
	%Menus/Character.show()
