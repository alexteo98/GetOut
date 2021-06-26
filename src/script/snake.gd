extends Node

const speed = 20
const gap = -50
var direction = Vector2(speed,0)
var next_tail_dir = Vector2(speed,0)
var prev_dir = Vector2(speed,0)
signal endgame
signal increase_score
#var curr_score = 0

onready var tail = preload("res://src/scene/Snake_tail.tscn")

func _ready():
	_addTail()
	_addTail()
	_addTail()
	_addTail()
	_addTail()
	_addTail()
	_addTail()
	pass

func _process(delta):
	
	if (Input.is_action_pressed("ui_up")):
		direction = Vector2(0,speed * -1)
		pass
	elif (Input.is_action_pressed("ui_down")):
		direction = Vector2(0,speed)
		pass
	elif (Input.is_action_pressed("ui_left")):
		direction = Vector2(-1 * speed,0)
		pass
	elif (Input.is_action_pressed("ui_right")):
		direction = Vector2(speed,0)
		pass
	_moveSnake()
	pass

func _moveSnake():
	var dir_change = false
	if (prev_dir != direction):
		prev_dir = direction
		dir_change = true
	var head_pos = get_node("head").position
	get_node("head").position += direction/2

	if (dir_change):
		for i in range(1,get_child_count()):
			get_child(i).add_to_tail(head_pos,direction)

func _addTail():
	emit_signal("increase_score")
	var inst = tail.instance()
	var prev_tail = get_child(get_child_count()-1)
	if (prev_tail.name != "head"):
		inst.cur_dir = prev_tail.cur_dir
		for i in range (0,prev_tail.pos_array.size()):
			inst.pos_array.append(prev_dir.pos_array[i])
			inst.directions.append(prev_dir.directions[i])
		inst.position = prev_tail.position + prev_tail.cur_dir * gap / speed 
	else:
		inst.cur_dir = direction
		inst.position = (prev_tail.position + (direction * gap) / speed ) 
	add_child(inst)

func on_collision():
	emit_signal("endgame")
	pass


func _on_head_area_entered(area):
	if (area.name == "wall_left" or area.name == "wall_right" or area.name == "wall_top" or area.name == "wall_bottom"):
		emit_signal("endgame")
	pass # Replace with function body.
