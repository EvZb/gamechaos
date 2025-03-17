extends Node

var MAIN_MENU_OPEN:bool = true
var MULTIPLAYER:bool = false
var HOST:bool = true
var GAMERUNNING:bool = false
const BIOMES:Dictionary[Variant,Vector2i] = {
	"Forest":Vector2i(0,0),
	"Mountains":Vector2i(0,1),
	"Plains":Vector2i(0,2),
	"Desert":Vector2i(0,3),
	"Snow":Vector2i(0,4)
}
const AREAPATH:String = "/root/Main/Game/Area/"
const WORLDPATH:String = "/root/Main/Game/World/"
const TEXTURES:Dictionary = {
	"Biome":null,
	"Area":null,
	"Ground":null,
	"Floor":null,
	"Wall":null,
	"Object":null,
	"Item":null,
	"Character":null,
	"Creature":null
}
var IMats:PackedStringArray
var IMat:Array[BaseMat]
var ITypes:PackedStringArray
var IType:Array[BaseType]
