extends KinematicBody2D

var run: bool = false

var basicspeed = 4
var speed = basicspeed
var energy = 100
var energyCap = 150
var shieldCount = 0
const energyDecrement = 0.5
const energyIncrement = 0.1
var direction = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

func _process(delta):
	#running speed boost
	if (Input.is_action_pressed("shift")):
		if energy>0:
			speed = basicspeed * 2
	else:
		speed = basicspeed
		
	recoverEnergy()
	
	if (Input.is_action_pressed("ui_up")):
		direction = Vector2(0,speed * -1)
		if (speed>basicspeed):
			energy-=energyDecrement
	elif (Input.is_action_pressed("ui_down")):
		direction = Vector2(0,speed)
		if (speed>basicspeed):
			energy-=energyDecrement
	elif (Input.is_action_pressed("ui_left")):
		direction = Vector2(-1 * speed,0)
		if (speed>basicspeed):
			energy-=energyDecrement
	elif (Input.is_action_pressed("ui_right")):
		direction = Vector2(speed,0)
		if (speed>basicspeed):
			energy-=energyDecrement
	else:
		direction = Vector2(0,0)
		pass
		
	if energy<=0:
			speed = basicspeed
	
	get_node("Sprite").position += direction
	get_node("CollisionShape2D").position += direction
	move_and_slide(direction, Vector2(0,0), false, 4, 0.785, false)

	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is RigidBody2D:
			print("Collided!")
	#.updateEnergy(energy)
	get_parent().updateEnergy(energy)
	pass

func increaseEnergy(amt):
	energy+=amt
	if energy >= energyCap:
		energy = energyCap

func increaseBaseSpd():
	basicspeed += 1

func increaseScore(incr):
	get_parent().increaseScore(incr)
	
func getShield():
	shieldCount += 1

func recoverEnergy():
	if (energy < energyCap):
		energy+=energyIncrement
		if (energy >= energyCap):
			energy = energyCap
