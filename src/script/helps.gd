extends Node

onready var mazeHelp = preload("res://src/scene/help-maze.tscn")
onready var mazeHelp2 = preload("res://src/scene/help-maze-2.tscn")
onready var snakeHelp = preload("res://src/scene/help-snake.tscn")
onready var flappyHelp = preload("res://src/scene/help-flappybird.tscn")
var active
var pageNo = 0

func _ready():
	pass 

func start():
	pageNo = 1
	display(mazeHelp)

func display(help):
	var inst = help.instance()
	get_parent().add_child(inst)
	inst.raise()
	active = inst

func nextPage():
	get_parent().remove_child(active)
	if pageNo == 1:
		display(mazeHelp2)
		pageNo = 2
	elif pageNo == 2:
		display(snakeHelp)
		pageNo = 3
	elif pageNo == 3:
		display(flappyHelp)
		pageNo = 4
	else:
		pass

func closeAll():
	get_parent().remove_child(active)
	pageNo=0
	pass
