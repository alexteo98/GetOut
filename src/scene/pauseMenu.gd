extends CanvasLayer


func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print("pause menu paused pressed")
		PauseMenu.close()


func _on_btnQuit_Pressed():
	pass

func _on_btnMainMenu_Pressed():
	pass

func _on_btnSettings_Pressed():
	SettingsMenu.show()

func _on_btnResume_Pressed():
	PauseMenu.close()

func _on_btnHelp_Pressed():
	Helps.start()
