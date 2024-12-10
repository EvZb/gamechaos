extends Control

func reload() -> void:
	hide_menus()
	$Menus/Main.show()

func hide_menus() -> void:
	$Menus/Main.hide()
	$Menus/Character.hide()
	$Menus/World.hide()
