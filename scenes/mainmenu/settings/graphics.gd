extends Control

var Resolutions = PackedVector2Array([Vector2(854,480),Vector2(960,540),Vector2(1024,576),Vector2(1280,720),Vector2(1366,768),Vector2(1600,900),Vector2(1920,1080)])
var Setting = S.Load("Graphics")

func _ready() -> void:
	$Fullscreen.select(int(Setting["Fullscreen"]))
	$Resolution.select(Resolutions.find(Vector2(Setting["Resolution"])))

func _on_apply_pressed() -> void:
	Setting["Fullscreen"] = bool($Fullscreen.get_selected_id())
	Setting["Resolution"] = Vector2i(Resolutions[$Resolution.get_selected_id()])
	S.Save("Graphics",Setting)
	S.Apply()
