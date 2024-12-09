extends Control

func _ready() -> void:
	hide_menus()

func hide_menus() -> void:
	$Options/Game.hide()
	$Options/Controls.hide()
	$Options/Graphics.hide()
	$Options/Other.hide()

func _on_game_pressed() -> void:
	hide_menus()
	$Options/Game.show()

func _on_controls_pressed() -> void:
	hide_menus()
	$Options/Controls.show()

func _on_graphics_pressed() -> void:
	hide_menus()
	$Options/Graphics.show()

func _on_other_pressed() -> void:
	hide_menus()
	$Options/Other.show()
