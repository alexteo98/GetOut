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
	get_tree().change_scene("res://src/scene/Main Menu.tscn")
	PauseMenu.close()
	pass

func _on_btnSettings_Pressed():
	PauseMenu.hide()
	SettingsMenu.show()

func _on_btnResume_Pressed():
	PauseMenu.close()

func _on_btnHelp_Pressed():
	PauseMenu.hide()
	Helps.start()
