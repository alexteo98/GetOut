extends KinematicBody2D


const speed = 2 
var direction = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

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
	else:
		direction = Vector2(0,0)
		pass
	get_node("Sprite").position += direction
	get_node("CollisionShape2D").position += direction
	pass
