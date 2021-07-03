extends Node

onready var mazeHelp = preload("res://src/scene/help-maze.tscn")
onready var snakeHelp = preload("res://src/scene/help-snake.tscn")
onready var flappyHelp = preload("res://src/scene/help-flappybird.tscn")

func _ready():	
	pass 

func start():
	display(mazeHelp)

func display(help):
	var inst = help.instance()
	get_parent().add_child(inst)
	inst.raise()
	inst.get_child(0).connect("nextPageSnake",self,"display",[snakeHelp])


func nextPage():
	pass
