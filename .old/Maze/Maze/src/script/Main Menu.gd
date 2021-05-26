extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const delay = 0.15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton2_pressed():
	$"SFX-mouseClick".play()
	yield(get_tree().create_timer(delay), "timeout")
	get_tree().change_scene("res://src/scene/Settings Tab.tscn")


func _on_TextureButton3_pressed():
	$"SFX-mouseClick".play()
	yield(get_tree().create_timer(delay), "timeout")
	get_tree().quit()


func _on_TextureButton_pressed():
	$"SFX-mouseClick".play()
	yield(get_tree().create_timer(delay), "timeout")
	get_tree().change_scene("res://src/scene/Maze.tscn")
	
func _wait(time):
	yield(get_tree().create_timer(time), "timeout")
