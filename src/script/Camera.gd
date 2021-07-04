extends Camera2D

onready var bird = get_parent().get_child(1)

func _ready():
	#OS.set_window_size(Vector2(288,512))
	get_tree().set_screen_stretch(1,1,Vector2(144,256),1)
	set_physics_process(true)
	pass # Replace with function body.

func get_total_position():
	return get_position() + get_offset()

func _physics_process(delta):
	set_position(Vector2(bird.get_position().x, get_position().y))
	pass

func pause():
	get_tree().set_screen_stretch(1,1,Vector2(1024,600),1)
	
func resume():
	get_tree().set_screen_stretch(1,1,Vector2(144,256),1)
