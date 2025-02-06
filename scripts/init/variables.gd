extends Node

var MAIN_MENU_OPEN:int = true
var MULTIPLAYER:bool = true
var GAMERUNNING:bool = false
const BIOMETILES:Array[Vector2i] = [Vector2i(0,0),Vector2i(0,1),Vector2i(0,2),Vector2i(0,3),Vector2i(0,4)]
const BIOMENAMES:PackedStringArray = ["Forest","Mountains","Plains","Desert","Snow"]
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
