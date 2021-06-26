extends Area2D

var curr_dir = Vector2(0,0)
var directions = []
var pos_array = []

signal tail_collision

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += curr_dir/2
	if (directions.size() > 0):
		if (position == pos_array[0]):
			curr_dir = directions[0]
			remove_tail()

func remove_tail():
	directions.pop_front()
	pos_array.pop_front()

func add_tail(head_pos,dir):
	pos_array.append(head_pos)
	directions.append(dir)

func _on_tail_area_entered(area):
	if (area.name == "head"):
		#get_tree().reload_current_scene()
		print("collided with head")
		emit_signal("tail_collision")
	pass # Replace with function body.
