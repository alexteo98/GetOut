extends Node2D

var speed = 15
var direction = Vector2(speed,0)
var gap = -60
var next_tail_dir = Vector2(speed,0)
var prev_dir = Vector2(speed,0)

onready var tail = preload("res://src/scene/tail.tscn")
signal tail_collision
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func end_game():
	print("snake collision")
	emit_signal("tail_collision")

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	moveSnake()
	pass

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
