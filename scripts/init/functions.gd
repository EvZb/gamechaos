extends Node

func SetTile(layer:String,coord:Vector2i,tile:int) -> void:
	get_node(V.LAYERPATH+layer).set_cell(coord,0,Vector2i(tile,0))

func Log(message:String,newentry:bool=true) -> void:
	if(newentry):
		if(V.LOGINDEX == 99): V.LOGINDEX = 0
		else: V.LOGINDEX += 1
		V.SYSTEMLOG[V.LOGINDEX] = message
	else:	V.SYSTEMLOG[V.LOGINDEX] += message

func GenArea() -> void:pass

func GenLayer() -> void:pass
