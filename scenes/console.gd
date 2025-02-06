extends Control

var line
var num = 0
var shown = false

func Toggle() -> void:
	if(Input.is_action_just_pressed("console")):
		if(shown):
			hide()
			shown = false
		else:
			show()
			shown = true

func Log(text) -> void:
	if(num > 3):
		$Log.get_child(0).free()
		num -= 1
	line = $Log.get_child(num).duplicate()
	$Log.add_child(line)
	line.text = text
	num += 1

func _on_line_edit_text_submitted(text:String) -> void:
	Log(text)
