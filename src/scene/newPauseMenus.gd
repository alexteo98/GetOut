extends NinePatchRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal resumeGame

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		#emit_signal("resumeGame")
		pass
	pass
	
func closeSettings():
	print("sad")
	pass

func _on_TextureButton_pressed():
	emit_signal("resumeGame")
	pass # Replace with function body.


func _on_TextureButton2_pressed():
	$Control.show()
	pass # Replace with function body.


func _on_Control_close_settings():
	$Control.hide()
	pass # Replace with function body.


func _on_TextureButton3_pressed():
	emit_signal("resumeGame")
	get_tree().change_scene("res://src/scene/Main Menu.tscn")
	pass # Replace with function body.


func _on_TextureButton4_pressed():
	get_tree().quit()
	pass # Replace with function body.
