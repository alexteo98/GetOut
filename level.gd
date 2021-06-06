extends Node2D

var curr_score = 0

onready var food = preload("res://src/scene/food.tscn") 
onready var wall = preload("res://src/scene/snake walls.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var walls = wall.instance() 
	walls.connect("wall_collision",self,"end_game")
	add_child(walls)
	add_food()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$score.text = "Score: " + str(curr_score)
	pass

func add_food():
	var inst = food.instance()
	inst.position = Vector2(rand_range(25,999),rand_range(25,575))
	inst.connect("food_eaten",self,"spawn_new")
	add_child(inst)
	pass

func spawn_new():
	curr_score += 1
	add_food()
	get_node("snake").add_tail()

func end_game():
	print("game ended")
	get_tree().reload_current_scene()
