extends CanvasLayer

signal close_settings

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const delay = 0.15
var masterVolume = 100
var BGMVolume = 100
var SFXVolume = 100



# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HSlider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))*100
	$VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HSlider2.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("BGM")))*100
	$VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HSlider3.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))*100
	$VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer3/CheckButton.pressed = !AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))
	$VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer3/CheckButton2.pressed = !AudioServer.is_bus_mute(AudioServer.get_bus_index("BGM"))
	$VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer3/CheckButton3.pressed = !AudioServer.is_bus_mute(AudioServer.get_bus_index("SFX"))
	pass # Replace with function body.



func _on_TextureButton_pressed():
	$SFX.play()
	yield(get_tree().create_timer(delay), "timeout")
	PauseMenu.unhide()
	SettingsMenu.close()

func _on_CheckButton2_toggled(button_pressed):
	$SFX.play()
	yield(get_tree().create_timer(delay), "timeout")
	if (button_pressed==true):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("BGM"),false)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("BGM"),true)

func _on_CheckButton_toggled(button_pressed):
	if (button_pressed==true):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),false)
		$SFX.play()
		yield(get_tree().create_timer(delay), "timeout")
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),true)


func _on_CheckButton3_toggled(button_pressed):
	if (button_pressed==true):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),false)
		$SFX.play()
		yield(get_tree().create_timer(delay), "timeout")
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),true)

func _wait(time):
	yield(get_tree().create_timer(time), "timeout")

func _on_HSlider_value_changed(value):
	_changeMasterVolume(value)

func _on_HSlider2_value_changed(value):
	_changeBGMVolume(value)

func _on_HSlider3_value_changed(value):
	_changeSFXVolume(value)

func _changeMasterVolume(value):
	masterVolume = value
	$VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/Label2.text = "Master Volume (" + str(masterVolume) + "%)"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(masterVolume/100))

func _changeBGMVolume(value):
	BGMVolume = value
	$VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/Label3.text = "BackGround Music (" + str(BGMVolume) + "%)"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), linear2db(BGMVolume/100))

func _changeSFXVolume(value):
	SFXVolume = value
	$VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/Label4.text = "Sound Effects (" + str(SFXVolume) + "%)"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(SFXVolume/100))
