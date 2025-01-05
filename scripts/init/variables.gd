extends Node

var MAIN_MENU_OPEN:int = true
var MULTIPLAYER:bool = true
var GAMERUNNING:bool = false
var SYSTEMLOG:PackedStringArray
var LOGINDEX:int = 0
const BIOMETILES:Array[Vector2i] = [Vector2i(0,0),Vector2i(1,0),Vector2i(2,0),Vector2i(3,0),Vector2i(4,0),Vector2i(5,0),Vector2i(6,0),Vector2i(7,0),Vector2i(8,0),Vector2i(9,0)]
const BIOMENAMES:PackedStringArray = ["Red","Orange","Yellow","Green","Teal","Blue","Pink","White","Grey","Black"]
const LAYERPATH:String = "/root/Main/Game/World/Layers/"
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
var Data = SaveData.new()
var IMats:PackedStringArray
var IMat:Array[BaseMat]
var ITypes:PackedStringArray
var IType:Array[BaseType]
