extends TextureButton

var first = true

func _ready():
	#connect("pressed", self, "_on_pressed")
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("flap") and first:
		print ("input")
		first = false
		_on_pressed()
		pass


func _on_pressed():
	print ("press")
	var bird = get_parent().get_parent().get_child(1)
	if bird:
		bird.set_state(bird.STATE_FLAPPING)
	
	hide()
	pass
