extends Area2D

var directions = []
var pos_array = []
var cur_dir = Vector2()

func _process(delta):
	if (directions.size() > 0):
		if (position == pos_array[0]):
			cur_dir = directions[0]
			remove_from_tail()
	position += cur_dir/2
	
func remove_from_tail():
	directions.pop_front()
	pos_array.pop_front()
	
func add_to_tail(head_pos,direction):
	pos_array.append(head_pos)
	directions.append(direction)
	pass


	
signal endgame

func _on_tail_area_entered(area):
	if (area.name == "head"):
		emit_signal("endgame")
		print("reset")
	pass # Replace with function body.
