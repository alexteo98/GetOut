extends KinematicBody2D


const speed = 5 
var direction = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Sprite").position.x = 800
	get_node("Sprite").position.y = 800
	get_node("CollisionShape2D").position.x = 800
	get_node("CollisionShape2D").position.y = 800
	get_node("Area2D").position.y = 800
	get_node("Area2D").position.x = 800

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
	#get_node("Sprite").position += direction
	#get_node("CollisionShape2D").position += direction
	#move_and_slide(direction, Vector2(0,0), false, 4, 0.785, false)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is RigidBody2D:
			print("Collided!")
	pass

func _moveMonster():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.hit()
