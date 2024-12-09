class_name GameTime

var Minute:int = 0
var Hour:int = 0
var Day:int = 0
var Month:int = 0
var Year:int = 0

func Date() -> String: return str(Day)+"/"+str(Month)+"/"+str(Year)

func Times() -> PackedInt32Array: return [Minute,Hour,Day,Month,Year]

func Pass() -> void:
	Minute += 1
	if(Minute > 59):
		Minute -= 60
		Hour += 1
		if(Hour > 23):
			Hour -= 24
			Day += 1
			if(Day > 28):
				Day -= 28
				Month += 1
				if(Month > 13):
					Year += 1
					Day = 0
					Month = 0
