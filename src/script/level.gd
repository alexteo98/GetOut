extends Node2D

var curr_score = 0
var paused = false

const TARGET_SCORE = 2
onready var food = preload("res://src/scene/food.tscn") 
onready var wall = preload("res://src/scene/snake walls.tscn")
onready var snake = preload("res://src/scene/snake.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	print("snake loaded")
	$Control.hide()
	paused = false
	var walls = wall.instance() 
	walls.connect("wall_collision",self,"end_game")
	snake.connect("tail_collision",self,"end_game")
	add_child(walls)
	add_food()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		if (paused == true):
			resumeGame()
		else:
			pauseGame()
	$score.text = "Score: " + str(curr_score)
	if curr_score == TARGET_SCORE:
		gameComplete()
	pass

func pauseGame():
	$Control.show()
	$Control.raise()
	get_node("snake").get_tree().paused = true
	#$snake.get_tree().paused = true
	paused = true
	pass

func resumeGame():
	$Control.hide()
	get_node("snake").get_tree().paused = false
	paused = false
	pass

func gameComplete():
	print("Game Completed")
	get_parent().resume()
	get_parent().remove_child(self)
	

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


func _on_snake_tail_collision():
	end_game()
	pass # Replace with function body.


func _on_Control_resumeGame():
	resumeGame()
	pass # Replace with function body.
