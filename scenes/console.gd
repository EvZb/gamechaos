extends CanvasLayer

var line
var num = 0
var shown = false

var cmd = {
	"get":func(a):Log(str(get_node("/root/"+a[0]).get(a[1]))),
	"help":func(_a):Log(str(desc.keys())),
	"host":func(a):$/root/Main/Multiplayer.Host(int(a[0]),int(a[1])),
	"join":func(a):$/root/Main/Multiplayer.Join(a[0],int(a[1])),
	"leave":func(_a):$/root/Main/Multiplayer.Leave(),
	"list":func(_a):Log(str($/root/Main/Multiplayer.players.keys())),
	"load":func(a):F.LoadWorld(a[0],int(a[1]));Log("Load ["+a[0]+"] ("+a[1]+")"),
	"math":func(a):var temp=Expression.new();temp.parse("x"+a[1]+"y",["x","y"]);Log(a[0]+a[1]+a[2]+" = "+str(temp.execute([float(a[0]),float(a[2])]))),
	"save":func(a):F.SaveWorld(a[0],int(a[1]));Log("Save ["+a[0]+"] ("+a[1]+")"),
	"spawn":func(_a):$/root/Main/Game.spawn_player();$/root/Main/Game.pause(false),
	"test":func(a):$/root/Main/Multiplayer/SynchServer.test=$/root/Main/Multiplayer/SynchServer.test*int(a[0]);Log(str($/root/Main/Multiplayer/SynchServer.test))
}
var arguments = {
	"get":";",
	"help":"",
	"host":"27772;8",
	"join":"127.0.0.1;27772",
	"leave":"",
	"list":"",
	"load":"test;0",
	"math":"0;+;0",
	"save":"test;0",
	"spawn":"",
	"test":"1"
}
var desc = {
	"get":"Show a property from a node. | get (nodepath :) (property :)",
	"help":"Shows a list of commands. | command (argument type :default value) | Use '#' or ' ' to represent the default value of an argument.",
	"host":"Start hosting multiplayer in your game. | host (port :27772) (max players :8)",
	"join":"Join a multiplayer game. | join (ip :127.0.0.1) (port :27772)",
	"leave":"Disconnect from a multiplayer game. | leave (# :)",
	"list":"Lists players connected to the multiplayer game. | list (# :)",
	"load":"Load a saved game. | load (world name :test) (save number :0)",
	"math":"Math. It is not very useful. | math (number :0) (operator :+) (number :0)",
	"save":"Save the game. | save (world name :test) (save number :0)",
	"spawn":"Spawn the player character. | spawn (# :)",
	"test":"Testing multiplayer. | test (# :)"
}

func Toggle() -> void:
	if(Input.is_action_just_pressed("console")):
		if(shown):
			hide()
			shown = false
		else:
			show()
			shown = true

func Log(text:String) -> void:
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

func _on_input_submitted(text:String) -> void:
	var input = text.split(" ")
	if(cmd.has(input[0])):
		if(input.size() == 1): Log(desc[input[0]])
		else:
			var args = arguments[input[0]].split(";")
			if(args.size() + 1 == input.size()):
				for arg in args.size():
					if !(input[arg + 1] == "#" or input[arg + 1].is_empty()):
						args[arg] = input[arg + 1]
				cmd[input[0]].call(args)
			else: Log("Incorrect amount of arguments. Expected %d and recieved %d" % [args.size(),input.size() - 1])

	else:Log("Unknown command; type 'help #' for a list of commands.")
	$Input.clear()
