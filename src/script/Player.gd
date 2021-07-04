extends KinematicBody2D

var run: bool = false
var disabled: bool = false
var basicspeed = 4
var speed = basicspeed
var energy = 100
var energyCap = 150
var shieldCount = 0
const energyDecrement = 0.5
const energyIncrement = 0.05
var direction = Vector2()

func _ready():
  pass

func _process(delta):
	if disabled:
		pass
	else:
		#running speed boost
		if (Input.is_action_pressed("shift")):
			if energy>0:
				speed = basicspeed * 1.5
		else:
			speed = basicspeed
			
		recoverEnergy()
		
		if (Input.is_action_pressed("ui_up")):
			print("player moving up")
			direction = Vector2(0,speed * -1)
			if (speed>basicspeed):
				energy-=energyDecrement
		elif (Input.is_action_pressed("ui_down")):
			print("player moving down")
			direction = Vector2(0,speed)
			if (speed>basicspeed):
				energy-=energyDecrement
		elif (Input.is_action_pressed("ui_left")):
			print("player moving left")
			direction = Vector2(-1 * speed,0)
			if (speed>basicspeed):
				energy-=energyDecrement
		elif (Input.is_action_pressed("ui_right")):
			print("player moving right")
			direction = Vector2(speed,0)
			if (speed>basicspeed):
				energy-=energyDecrement
		else:
			direction = Vector2(0,0)
			
		if energy<=0:
				speed = basicspeed
		
		get_node("Sprite").position += direction
		get_node("CollisionShape2D").position += direction
		move_and_slide(direction, Vector2(0,0), false, 4, 0.785, false)

		for index in get_slide_count():
			var collision = get_slide_collision(index)
			if collision.collider is RigidBody2D:
				print("Collided!")
		get_parent().updateEnergy(energy)

func increaseEnergy(amt):
	print("incr energy:" + str(amt))
	energy += amt
	if energy >= energyCap:
		energy = energyCap

func increaseBaseSpd():
	print("basic speed increased")
	basicspeed += 1

func increaseScore(incr):
	get_parent().increaseScore(incr)
	print("score increased by: " + str(incr) + "current score: " + str(get_parent().getScore()))

func getShield():
	shieldCount += 1
	print("increase shield by 1" + "current shield count: " + str(shieldCount))

func recoverEnergy():
	print("recovering energy")
	if (energy < energyCap):
		energy+=energyIncrement
		if (energy >= energyCap):
			energy = energyCap

func disableMovement():
	disabled = true
	
func enableMovement():
	disabled = false
