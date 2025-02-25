class_name Entity

var Name:String = "Default"
var InventoryId:int 
var Position:Vector2i
var Type:String = "Default"#(Animal, Citizen, Companion, Monster, Person, Player)
var HostileTypes:PackedStringArray
var Race:String = "Default"
var Sex:String = "None"#(None, Male, Female)
var Health:int = 1
var Magic:int = 1
var Spirit:int = 1
var MaxHealth:int = 1
var MaxMagic:int = 1
var MaxSpirit:int = 1
var Potential:Dictionary = {
	"Level":1
}
var Stat:Dictionary = {
	"Level":1
}
var Growth:Dictionary = {
	"Level":0
}
var Relations:Dictionary
var Movement:int = 1#walk speed in tiles per (game) minute
var Speed:int = 1#attack speed
var Intelligence:int = 1
var Strength:int = 1
var Dexterity:int = 1
var Regen:int = 0
var Recovery:int = 0
var Luck:int = 1
var Accuracy:int = 0
var Evasion:int = 0
var Vision:int = 1
var Hearing:int = 1
var Sound:int = 0
var Sight:int = 0
var Bulk:int = 1
var Mass:int = 1
var Constitution:int = 1
var Will:int =  0
var Stability:int = 0
var Resistance:Dictionary = {"Health":0,"Magic":0,"Spirit":0,"Crit":0}
var Defense:Dictionary = {"Health":0,"Magic":0,"Spirit":0}
var Immune:Dictionary
var Effects:Dictionary
