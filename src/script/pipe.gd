# script: pipe

extends StaticBody2D

onready var right  = get_node("right")
onready var camera = get_parent().get_parent().get_parent().get_child(0)

func _ready():
	set_process(true)
	add_to_group(game.GROUP_PIPES)
	pass

func _process(delta):
	if camera == null: return
	
	if right.get_global_position().x <= camera.get_total_position().x:
		queue_free()
	pass

