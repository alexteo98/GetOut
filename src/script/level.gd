extends Node2D

var curr_score = 0
var started = false

const TARGET_SCORE = 1
onready var food = preload("res://src/scene/food.tscn") 
onready var wall = preload("res://src/scene/snake walls.tscn")
onready var snake = preload("res://src/scene/snake.tscn")

func _ready():
	var walls = wall.instance() 
	walls.connect("wall_collision",self,"end_game")
	snake.connect("tail_collision",self,"end_game")
	add_child(walls)
	resume()
	print("snake loaded")

func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		pause()
	$score.text = "Score: " + str(curr_score)
	if curr_score == TARGET_SCORE:
		gameComplete()
	pass

func add_food():
	var inst = food.instance()
	inst.position = Vector2(rand_range(25,999),rand_range(25,575))
	inst.connect("food_eaten",self,"spawn_new")
	add_child(inst)

func spawn_new():
	curr_score += 1
	add_food()
	get_node("snake").add_tail()

func _on_snake_tail_collision():
	end_game()
	pass # Replace with function body.

#####################################################
func started():
	return started

func end_game():
	print("game ended")
	restart()

func gameComplete():
	print("Game Completed")
	get_parent().showAll()
	get_parent().zoomIn()
	get_parent().resume()
	get_parent().setSnakeStatus(true)
	get_parent().remove_child(self)

func pause():
	#get_tree().paused = true
	#PauseMenu.show(self)
	pass

func resume():
	get_tree().paused = false

func startGame():
	$Label.hide()
	started = true
	add_food()

func restart():
	get_parent().startSnake()
	get_parent().resume()
	get_parent().remove_child(self)
