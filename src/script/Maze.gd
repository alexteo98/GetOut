extends Node2D

const N = 1
const E = 2
const S = 4
const W = 8

const NO_OF_MINIGAMES = 2
var snake_cleared = false
var flappy_cleared = false
var score = 0
var score_acc = 0 
var time = 0
var snakeTries = 0
var flappyTries = 0

const SHIELD = 3
const GOLD = 2
const SHOES = 1
const ENERGY_POT = 5
const SNAKE_MINIGAME = 3
const SPIKE_TRAP = 3
const SLOW_TRAP = 4
const MONSTER = 3

const TOTAL_CHESTS = [SHIELD,GOLD,SHOES,ENERGY_POT,SNAKE_MINIGAME,SPIKE_TRAP,SLOW_TRAP,MONSTER]
onready var redChest = preload("res://src/scene/red-chest.tscn")
onready var blueChest = preload("res://src/scene/blue-chest.tscn")
onready var greenChest = preload("res://src/scene/green-chest.tscn")
onready var yellowChest = preload("res://src/scene/yellow-chest.tscn")
onready var snakePortal = preload("res://src/scene/snake-minigame.tscn")
onready var snakeGame = preload("res://src/scene/level.tscn")
onready var flappyGame = preload("res://src/scene/Stage.tscn")
onready var spikeTrap = preload("res://src/scene/spikeTrap.tscn")
onready var slowTrap = preload("res://src/scene/slowTrap.tscn")
onready var monster = preload("res://src/scene/Monster.tscn")
var activeMiniGame: bool = false

var cell_walls = {Vector2(0, -2): N, Vector2(2, 0): E, 
				  Vector2(0, 2): S, Vector2(-2, 0): W}

var spawns=[]

var tile_size = 25  # tile size (in pixels)
var width = 40  # width of map (in tiles)
var height = 24  # height of map (in tiles)

var map_seed = 0

# fraction of walls to remove
var erase_fraction = 0.2

# get a reference to the map for convenience
onready var Map = get_node("LevelNavigation").get_node("TileMap")

func _ready():
	$EnergyBar.max_value = get_node("Player").energyCap
	$EnergyBar.set_position(Vector2(0,-140))
	$ScoreLbl.set_position(Vector2(400,-140)+$ScoreLbl.rect_position)
	$ShieldLbl.set_position(Vector2(50,-140)+$ShieldLbl.rect_position)
	$TimeLbl.set_position(Vector2(250,-140)+$TimeLbl.rect_position)
	updateScore()
	zoomIn()
	
	randomize()
	if !map_seed:
		map_seed = randi()
	seed(map_seed)
	print("Seed: ", map_seed)
	tile_size = Map.cell_size
	make_maze()
	erase_walls()
	spawnChests()
	
func check_neighbors(cell, unvisited):
	# returns an array of cell's unvisited neighbors
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list
	
func make_maze():
	var unvisited = []  # array of unvisited tiles
	var stack = []
	# fill the map with solid tiles
	Map.clear()
	for x in range(width):
		for y in range(height):
			Map.set_cellv(Vector2(x, y), N|E|S|W)
	for x in range(0, width, 2):
		for y in range(0, height, 2):
			unvisited.append(Vector2(x, y))
	var current = Vector2(0, 0)
	unvisited.erase(current)
	# execute recursive backtracker algorithm
	while unvisited:
		var neighbors = check_neighbors(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			# remove walls from *both* cells
			var dir = next - current
			var current_walls = Map.get_cellv(current) - cell_walls[dir]
			var next_walls = Map.get_cellv(next) - cell_walls[-dir]
			Map.set_cellv(current, current_walls)
			Map.set_cellv(next, next_walls)
			# insert intermediate cell
			if dir.x != 0:
				Map.set_cellv(current + dir/2, 5)
			else:
				Map.set_cellv(current + dir/2, 10)
			current = next
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()
		# yield(get_tree(), 'idle_frame')

func erase_walls():
	# randomly remove a number of the map's walls
	for i in range(int(width * height * erase_fraction)):
		var x = int(rand_range(2, width/2 - 2)) * 2
		var y = int(rand_range(2, height/2 - 2)) * 2
		var cell = Vector2(x, y)
		# pick random neighbor
		var neighbor = cell_walls.keys()[randi() % cell_walls.size()]
		# if there's a wall between them, remove it
		if Map.get_cellv(cell) & cell_walls[neighbor]:
			spawns.append(cell)
			var walls = Map.get_cellv(cell) - cell_walls[neighbor]
			var n_walls = Map.get_cellv(cell+neighbor) - cell_walls[-neighbor]
			Map.set_cellv(cell, walls)
			Map.set_cellv(cell+neighbor, n_walls)
			# insert intermediate cell
			if neighbor.x != 0:
				Map.set_cellv(cell+neighbor/2, 5)
			else:
				Map.set_cellv(cell+neighbor/2, 10)

func _process(delta):
	time += delta
	updateTime()
	if (Input.is_action_pressed("ui_cancel")):
		if !activeMiniGame:
			PauseMenu.show(self)
			pause()

func updateTime():
	var totalSeconds = int(time)
	var minutes = str("%02d" % (totalSeconds/60))
	var seconds = str("%02d" % (totalSeconds%60))
	$TimeLbl.text = "Time: " + str(minutes) + ":" + str(seconds)

func updateEnergy(energyLeft):
	$EnergyBar.value = energyLeft

func updateShield(n):
	$ShieldLbl.text = "Shield: " + str(n)

func updateScore():
	$ScoreLbl.text = "Score: " + str(score)

func increaseScore(incr):
	#print("incr score" + str(incr))
	score += incr
	updateScore()

func getScore():
	return score

func spawnChests():
	# number of boxes to spawn
	var spawnItems=0
	for i in TOTAL_CHESTS:
		spawnItems+=i
	
	for index in TOTAL_CHESTS.size():
		for j in TOTAL_CHESTS[index]:
			var k = rand_range(0,spawns.size()-1)

			var inst = null
			if index == 0:
				inst = redChest.instance()
			elif index == 1:
				inst = greenChest.instance()
			elif index == 2:
				inst = blueChest.instance()
			elif index == 3:
				inst = yellowChest.instance()
			elif index == 4:
				inst = snakePortal.instance()
				inst.connect("startMinigame",self,"startMinigame")
			elif index == 5:
				inst = spikeTrap.instance()
			elif index == 6:
				inst = slowTrap.instance()
			elif index == 7:
				inst = monster.instance()
			
			inst.position = spawns[k] * 64 - Vector2(-32,-32)
			spawns.remove(k)
			add_child(inst)

func hideAll():
	for i in range(get_child_count()):
		get_child(i).visible = false

func showAll():
	for i in get_child_count():
		get_child(i).visible = true
	get_child(4).visible = true
	get_child(5).visible = true

func startSnake():
	snakeTries += 1
	if snakeTries > 3:
		setSnakeStatus(true)
		showAll()
		zoomIn()
		resume()
		increaseScore(-1000)
		
	else: 
		hideAll()
		var inst = snakeGame.instance()
		zoomOut()
		pause()
		add_child(inst)
		activeMiniGame = true
		inst.show()

func startMinigame():
	if snake_cleared and flappy_cleared:
		closeGame()
	else:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var rand = rng.randi_range(0, 1)
		print(rand)
		
		if rand == 0:
			if !snake_cleared:
				startSnake()
			else:
				startMinigame()
		elif rand == 1:
			if !flappy_cleared:
				startFlappy()
			else:
				startMinigame()
		else:
			pass

func closeGame():
	var end = load("res://src/scene/game ended.tscn")
	var inst = end.instance()
	inst.setTime(time)
	inst.setScore(score)
	get_parent().add_child(inst)
	get_parent().remove_child(self)
	pass
	
func startFlappy():
	flappyTries += 1
	if flappyTries > 3:
		setFlappyStatus(true)
		get_tree().set_screen_stretch(1,1,Vector2(1024,600),1)
		showAll()
		zoomIn()
		resume()
		increaseScore(-1000)
	else:
		print("flappy started")
		var inst = flappyGame.instance()
		zoomOut()
		hideAll()
		pause()
		add_child(inst)
		activeMiniGame = true
		inst.show()
	
func pause():
	print("main maze paused called")
	get_tree().paused = true
	print(get_tree().paused)
	$Player.disableMovement()

func resume():
	get_tree().paused = false
	$Player.enableMovement()

func setSnakeStatus(status):
	snake_cleared = status
	increaseScore(1000)
	activeMiniGame = false

func getSnakeStatus():
	return snake_cleared

func setFlappyStatus(status):
	flappy_cleared = status
	increaseScore(1000)
	activeMiniGame = false

func getFlappyStatus():
	return flappy_cleared

func zoomIn():
	# Zoom settings for fit
	#$Camera2D.zoom = Vector2(2.5, 2.5)
	#$Camera2D.position = Map.map_to_world(Vector2(width/2+4, height/2+2.5))
	$Camera2D.zoom = Vector2(2.6, 2.7)
	$Camera2D.position = Map.map_to_world(Vector2(width/2+3, height/2+1))
	
func zoomOut():
	$Camera2D.zoom = Vector2(1,1)
	$Camera2D.position = Vector2(420,240)
