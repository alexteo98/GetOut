extends Node2D

func _ready():
	resume()

func pause():
	print("world pause")
	print(get_child_count())
	for i in range(get_child_count()-1):
		var child = get_child(i)
		if "visible" in child:
			child.visible = false
	
	PauseMenu.show(self)
	get_tree().paused = true

func resume():
	for i in range(get_child_count()-1):
		var child = get_child(i)
		if "visible" in child:
			child.visible = true
	get_tree().paused = false
