extends CanvasLayer

func _on_save_pressed() -> void:pass

func _on_join_pressed() -> void:
	if(M.Join($Menu/Config/Info/IP.text,int($Menu/Config/Info/Port.text),$Menu/Config/Info/Password.text)):pass#fail
	else:
		$Menu/Config.hide()
		$Menu/Servers.hide()
		hide()

func _on_start_pressed() -> void:
	var mp = int($Menu/Config/Create/MaxPlayers.text)
	var port = int($Menu/Config/Create/Port.text)
	if(port == clampi(port,1024,65535)):
		if(mp == clampi(mp,0,4095)):
			if(M.Host(port,mp,$Menu/Config/Create/Password.text)): return#creation failed
			else: hide()
		else: return
	else: return

func _on_back_pressed() -> void:
	V.MAIN_MENU_OPEN = true
	$/root/Main/MainMenu.show()
	hide()
