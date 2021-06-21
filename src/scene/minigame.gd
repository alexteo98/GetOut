extends Area2D

signal startSnake
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var snake = preload("res://src/scene/level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_snakeminigame_body_entered(body):
	if body.name == "Player":
		get_parent().remove_child(self)
		#startSnake()
		emit_signal("startSnake")
		
func startSnake():
	print("start snake")
	var inst = snake.instance()
	add_child(inst)
	#add_child(inst)
