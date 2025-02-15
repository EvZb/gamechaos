extends CanvasLayer

var line
var num = 0
var shown = false

var cmd = {
	"help":func(a):Log(str(desc.keys())),
	"load":func(a):F.LoadWorld(a[0],int(a[1]));Log("Load ["+a[0]+"] ("+a[1]+")"),
	"math":func(a):var temp=Expression.new();temp.parse("x"+a[1]+"y",["x","y"]);Log(a[0]+a[1]+a[2]+" = "+str(temp.execute([float(a[0]),float(a[2])]))),
	"save":func(a):F.SaveWorld(a[0],int(a[1]));Log("Save ["+a[0]+"] ("+a[1]+")")
}
var arguments = {
	"help":"",
	"load":"test;0",
	"math":"0;+;0",
	"save":"test;0"
}
var desc = {
	"help":"Shows a list of commands. | command (argument type :default value) | Use '#' or ' ' to represent the default value of an argument.",
	"load":"Load a saved game. | load (world name :test) (save number :0)",
	"math":"Math. It is not very useful. | math (number :0) (operator :+) (number :0)",
	"save":"Save the game. | save (world name :test) (save number :0)",
}

func Toggle() -> void:
	if(Input.is_action_just_pressed("console")):
		if(shown):
			hide()
			shown = false
		else:
			show()
			shown = true

func Log(text) -> void:
	if(num > 98):
		$Scroll/Log.get_child(0).free()
		num -= 1
		if($Scroll.scroll_vertical + 246 < $Scroll/Log.size.y): $Scroll.scroll_vertical -= 50
	line = $Scroll/Log.get_child(num).duplicate()
	$Scroll/Log.add_child(line)
	num += 1
	line.text = text
	await $Scroll.get_v_scroll_bar().changed
	if($Scroll/Log.size.y == $Scroll.scroll_vertical + 296): $Scroll.scroll_vertical += 50

func _on_line_edit_text_submitted(text:String) -> void:
	var input = text.split(" ")
	if(cmd.has(input[0])):
		if(input.size() == 1): Log(desc[input[0]])
		else:
			var args = arguments[input[0]].split(";")
			if(args.size() + 1 == input.size()):
				for arg in args.size():
					if !(input[arg + 1] == "#" or input[arg + 1] == ""):
						args[arg] = input[arg + 1]
				print(str(args))
				cmd[input[0]].call(args)
			else: Log("Incorrect amount of arguments. Expected %d and recieved %d" % [args.size(),input.size() - 1])

	else:Log("Unknown command; type 'help #' for a list of commands.")
	$Input.clear()
