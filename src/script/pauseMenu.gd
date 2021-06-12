extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const delay = 0.15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btnExit2Menu_pressed():
	$"SFX-mouseClick".play()
	yield(get_tree().create_timer(delay), "timeout")
	get_tree().change_scene("res://src/scene/Main Menu.tscn")
	pass # Replace with function body.


func _on_btnSettings_pressed():
	$"SFX-mouseClick".play()
	yield(get_tree().create_timer(delay), "timeout")
	get_tree().change_scene("res://src/scene/Settings Tab.tscn")
	pass # Replace with function body.
