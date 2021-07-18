extends KinematicBody2D

var rng = RandomNumberGenerator.new()

export (int) var speed = 200

var velocity = Vector2()
var prevprevDirection = 99999
var prevDirection
var facingRight = true
var player_spotted = false
onready var los = $LineOfSight

func _ready():
	rng.randomize()
	var initMove = 1 
	prevDirection = initMove
	pass


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if los.get_collider() != null: # if line of sight sees something
		#print("monster sees something....")
		#print(los.get_collider().name)
		if los.get_collider().name == "Player" :
			player_spotted = true
			print("monster spotted player")
		else:
			player_spotted = false
	
	if collision:
		#print("monster collided with " + collision.collider.name)
		changeDirection()
	else:
		move(prevDirection)

func _moveMonster():
	pass

func changeDirection():
	rng.randomize()
	var rand = rng.randi_range(0, 3)
	if rand == prevDirection or rand == prevprevDirection:
		changeDirection()
	else:
		prevprevDirection = prevDirection
		prevDirection = rand
		move(rand)

func move(direction):
	#direcPrinter(direction)
	if direction == 0: # move right
		get_node("Sprite").flip_h = false
		los.cast_to = Vector2(99999, 0)
		resetSpeed()
		if player_spotted == true:
			velocity.x += 600
		else:
			velocity.x += 200
	elif direction == 1: # move left
		get_node("Sprite").flip_h = true
		los.cast_to = Vector2(-99999, 0)
		resetSpeed()
		if player_spotted == true:
			velocity.x -= 600
		else:
			velocity.x -= 200
	elif direction == 2: # move down
		los.cast_to = Vector2(0, 99999)
		resetSpeed()
		if player_spotted == true:
			velocity.y += 600
		else:
			velocity.y += 200
	else: # move up
		resetSpeed()
		los.cast_to = Vector2(0, -99999)
		if player_spotted == true:
			velocity.y -= 600
		else:
			velocity.y -= 200

func direcPrinter(x):
	if x == 0:
		print("Moving right (0)")
		pass
	elif x == 1:
		pass
		print("Moving left (1)")
	elif x == 2:
		pass
		print("Moving down (2)")
	else:
		pass
		print("Moving up (3)")

func resetSpeed():
	velocity.y = 0
	velocity.x = 0

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.hit()
	if body.name == "TileMap":
		changeDirection()
