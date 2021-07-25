extends CanvasLayer

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print("pause menu paused pressed")
		PauseMenu.close()

func _on_btnQuit_Pressed():
	get_tree().quit()
	pass

func _on_btnMainMenu_Pressed():
	sounds.get_node("sfx_mouse_click").play()
	yield(get_tree().create_timer(0.15), "timeout")
	get_tree().change_scene("res://src/scene/Main Menu.tscn")
	PauseMenu.close()
	pass

func _on_btnSettings_Pressed():
	sounds.get_node("sfx_mouse_click").play()
	yield(get_tree().create_timer(0.15), "timeout")
	PauseMenu.hide()
	SettingsMenu.show()

func _on_btnResume_Pressed():
	sounds.get_node("sfx_mouse_click").play()
	yield(get_tree().create_timer(0.15), "timeout")
	PauseMenu.close()

func _on_btnHelp_Pressed():
	sounds.get_node("sfx_mouse_click").play()
	yield(get_tree().create_timer(0.15), "timeout")
	PauseMenu.hide()
	Helps.start()
