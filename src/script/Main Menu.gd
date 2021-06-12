extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const delay = 0.15
#onready var settings = preload("res://src/scene/Settings Tab.tscn")
#var inst


# Called when the node enters the scene tree for the first time.
func _ready():
	close_settings_menu()
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton2_pressed():
	$"SFX-mouseClick".play()
	yield(get_tree().create_timer(delay), "timeout")
	#get_tree().change_scene("res://src/scene/Settings Tab.tscn")
	open_settings_menu()
	

func _on_TextureButton3_pressed():
	$"SFX-mouseClick".play()
	yield(get_tree().create_timer(delay), "timeout")
	get_tree().quit()


func _on_TextureButton_pressed():
	$"SFX-mouseClick".play()
	yield(get_tree().create_timer(delay), "timeout")
	get_tree().change_scene("res://src/scene/level.tscn")
	
func _wait(time):
	yield(get_tree().create_timer(time), "timeout")

func close_settings_menu():
	get_node("Settings").hide()
	self.show()
	pass
	
func open_settings_menu():
	get_node("Settings").show()
	pass

func _on_Control_close_settings():
	close_settings_menu()
	pass # Replace with function body.
