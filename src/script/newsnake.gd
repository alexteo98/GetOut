extends Node2D

var speed = 15
var direction = Vector2(0,0)
var gap = -60
var next_tail_dir = Vector2(speed,0)
var prev_dir = Vector2(speed,0)

var DIRECTION_UP = Vector2(0,speed * -1)
var DIRECTION_DOWN = Vector2(0,speed)
var DIRECTION_LEFT = Vector2(-1 * speed,0)
var DIRECTION_RIGHT = Vector2(speed,0)

onready var tail = preload("res://src/scene/tail.tscn")
signal tail_collision

func _ready():
	pass

func end_game():
	print("snake collision")
	emit_signal("tail_collision")

func _process(delta):
	if isStarted():
		if (Input.is_action_pressed("ui_up")):
			if direction == DIRECTION_DOWN:
				pass
			else:
				direction = DIRECTION_UP
		elif (Input.is_action_pressed("ui_down")):
			if direction == DIRECTION_UP:
				pass
			else:
				direction = DIRECTION_DOWN
		elif (Input.is_action_pressed("ui_left")):
			if direction == DIRECTION_RIGHT:
				pass
			else:
				direction = DIRECTION_LEFT
		elif (Input.is_action_pressed("ui_right")):
			if direction == DIRECTION_LEFT:
				pass
			else:
				direction = DIRECTION_RIGHT
		moveSnake()
	else:
		if (Input.is_action_pressed("ui_select")):
			get_parent().startGame()

func isStarted():
	return get_parent().started()

func moveSnake():
	var head_pos = get_node("head").position
	get_node("head").position += direction/2
	
	var dirr_change = false
	if prev_dir != direction:
		prev_dir =direction
		dirr_change = true
	if dirr_change:
		for i in range(1,get_child_count()):
			get_child(i).add_tail(head_pos,direction) 

func add_tail():
	var inst = tail.instance()
	var prev_tail = get_child(get_child_count()-1)
	if prev_tail.name != "head":
		inst.curr_dir = prev_tail.curr_dir
		for i in range(0, prev_tail.pos_array.size()):
			inst.pos_array.append(prev_tail.pos_array[i])
			inst.directions.append(prev_tail.directions[i])
		inst.position = prev_tail.position + (prev_tail.curr_dir * gap / speed)
	else:
		inst.curr_dir = direction
		inst.position = prev_tail.position + (direction * gap / speed)
	add_child(inst)
	inst.connect("tail_collision",self,"end_game")
