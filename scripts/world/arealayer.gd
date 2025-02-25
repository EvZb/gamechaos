class_name AreaLayer

var Size:int = 32#32 should be the minimum
var Tile:PackedInt32Array
var Floor:PackedInt32Array
var Wall:PackedInt32Array
var Space:PackedInt32Array#whether a tile is occupied and by what
var Entities:Array#entitydata
var PlayerCount:int#amount of players on the layer
var Objects:Array[BaseObject]

func move(ent:int,dir:Vector2i) -> Vector2i:
	var sel = Entities[ent]
	sel.Position.x += dir.x
	sel.Position.y += dir.y
	sel.Position = sel.Position.clampi(0,Size - 1)
	return sel.Position
