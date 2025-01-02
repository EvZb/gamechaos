extends Node

func Apply() -> void:
	if(Graphics["Fullscreen"]): DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Graphics["Resolution"])

func Save(section:String,data:Dictionary) -> void:
	var file = ConfigFile.new()
	for setting in data:
		file.set_value(section,setting,data[setting])
	file.save("user://settings/"+section+".ini")

func Load(section:String) -> Dictionary:
	var file = ConfigFile.new()
	var check = file.load("user://settings/"+section+".ini")
	var settings = get(section)
	if check == OK:
		for setting in file.get_section_keys(section):
			settings[setting] = file.get_value(section,setting)
	return settings

var Game = {
	"TickRate": 4,
	"AutoTick": 0,
	"Username": "Player",
	"Password": "",
	}

var Controls = {
	"Default": true,
	}

var Graphics = {
	"Fullscreen": false,
	"Resolution": Vector2i(854,480),
	}

var Other = {
	"SystemLog": false,
	}

var Worldgen = {
	"Size": 128,
	}

var Servers = {
	"Default": {
		"IP": "127.0.0.1",
		"Port": 33322,
		"Character": {
			"Default": ""
		},
	},
}
