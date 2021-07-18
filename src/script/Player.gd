extends KinematicBody2D

var run: bool = false
var disabled: bool = false
var basicspeed: float = 3
var speed = basicspeed
var energy = 100
var energyCap = 100
var shieldCount = 0
const energyDecrement = 0.5
const energyIncrement = 0.05
var direction = Vector2()
var facingRight = true # currently facing direction
var running = false # checks if running
var slowed = false
var getHit = false

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
				running = true
		else:
			speed = basicspeed
			running = false
			
		recoverEnergy()
		
		if (Input.is_action_pressed("ui_up")):
			runningAnim()
			#print("player moving up")
			direction = Vector2(0,speed * -1)
			if (speed>basicspeed):
				energy-=energyDecrement
		elif (Input.is_action_pressed("ui_down")):
			runningAnim()
			#print("player moving down")
			direction = Vector2(0,speed)
			if (speed>basicspeed):
				energy-=energyDecrement
		elif (Input.is_action_pressed("ui_left")):
			facingRight = false
			#print("player moving left")
			runningAnim()
			direction = Vector2(-1 * speed,0)
			if (speed>basicspeed):
				energy-=energyDecrement
		elif (Input.is_action_pressed("ui_right")):
			facingRight = true
			#print("player moving right")
			direction = Vector2(speed,0)
			runningAnim()
			if (speed>basicspeed):
				energy-=energyDecrement
		else:
			get_node("anim").play("idle")
			direction = Vector2(0,0)
			
		if energy<=0:
				speed = basicspeed
		
		get_node("Sprite").position += direction
		get_node("CollisionShape2D").position += direction
		get_node("shield").position += direction
		move_and_slide(direction, Vector2(0,0), false, 4, 0.785, false)

		for index in get_slide_count():
			var collision = get_slide_collision(index)
			if collision.collider is RigidBody2D:
				print("Collided!")
				get_node("anim").play("collide")
		get_parent().updateEnergy(energy) 

func runningAnim():
	if running == true: 
		if facingRight == true:
			get_node("Sprite").flip_h = false
			if getHit == true:
				get_node("anim").play("collide")
			else:
				get_node("anim").play("run")
		else:
			get_node("Sprite").flip_h = true
			if getHit == true:
				get_node("anim").play("collide")
			else:
				get_node("anim").play("run")
	else:
		if facingRight == true:
			get_node("Sprite").flip_h = false
			if getHit == true:
				get_node("anim").play("collide")
			else:
				get_node("anim").play("stroll")
		else:
			get_node("Sprite").flip_h = true
			if getHit == true:
				get_node("anim").play("collide")
			else:
				get_node("anim").play("stroll")
	pass

func increaseEnergy(amt):
	energy += amt
	if energy >= energyCap:
		energy = energyCap

func increaseBaseSpd():
	print("basic speed increased")
	basicspeed += 0.5

func increaseScore(incr):
	get_parent().increaseScore(incr)
	print("score increased by: " + str(incr) + "current score: " + str(get_parent().getScore()))
	pass # CHANGE BACK

func getShield():
	shieldCount += 1
	updateShield()
	print("increase shield by 1" + "current shield count: " + str(shieldCount))
	visibleShield()

func useShield():
	if shieldCount <= 0:
		print("no more shields left")
	else:
		shieldCount -= 1
		updateShield()
		print("used 1 shield" + "current shield count: " + str(shieldCount))
	visibleShield()

func updateShield():
	get_parent().updateShield(shieldCount)

func slowDown():
	if !slowed:
		slowed = true
		basicspeed = basicspeed / 4
		print("slowed for 5 sec" + str(basicspeed))
		yield(get_tree().create_timer(5.0), "timeout")
		basicspeed = basicspeed * 4
		print("slow recovered" + str(basicspeed))
		slowed = false
	

func recoverEnergy():
	if (energy < energyCap):
		energy+=energyIncrement
		if (energy >= energyCap):
			energy = energyCap

func disableMovement():
	disabled = true
	
func enableMovement():
	disabled = false

func hit():
	print("hit")
	getHit = true
	if shieldCount <= 0:
		increaseScore(-100)
	else:
		useShield()
	yield(get_tree().create_timer(0.8), "timeout")
	getHit = false
	pass

func visibleShield():
	if shieldCount > 0:
		$shield.visible = true
	else:
		$shield.visible = false
