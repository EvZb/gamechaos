extends Control
var Name:String = "Default"
var Errors:int = 0
#influenced by race
var stat = {
	"AgeMin" = 16,
	"AgeMax" = 99,
	"Age" = 32,
	"HeightMax" = 100,
	"HeightMin" = 50,
	"Height" = 64,
	"WeightMax" = 100,
	"WeightMin" = 50,
	"Weight" = 64
}

func _on_name_input(text) -> void:
	if(text.is_empty()): Name = "Default"
	else: Name = text

func _on_number_box_input(text:String,id:String) -> void:
	var num:int = int(text)
	var smin:int = stat[id + "Min"]
	var smax:int = stat[id + "Max"]
	if(num == clampi(num, smin, smax)):
		stat[id] = num
		get_node(id).add_theme_color_override("font_color", Color.GRAY)
	else:
		stat[id] = randi() % (smax - smin) + smin
		get_node(id).add_theme_color_override("font_color", Color.DARK_RED)

func _on_finish_pressed() -> void:
	hide()
	$/root/Main/StartMenu.hide()
	%Menus/World.show()
