extends Node2D

const N = 1
const E = 2
const S = 4
const W = 8

onready var chest = preload("res://src/scene/red-chest.tscn")

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
onready var Map = $TileMap

func _ready():
	$Camera2D.zoom = Vector2(2.5, 2.5)
	$Camera2D.position = Map.map_to_world(Vector2(width/2+4, height/2+2.5))
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
		#yield(get_tree(), 'idle_frame')

func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		$pauseMenu.show()

func _on_pauseMenu_resumeGame():
	$pauseMenu.hide()
	pass # Replace with function body.

func updateEnergy(energyLeft):
	$Label.text = "Energy Left: " + str(energyLeft)
	
func spawnChests():
	# number of boxes to spawn
	var spawnItems = 10
	for i in range (0,spawnItems):
		var j =rand_range(0,spawns.size()-1)
		var inst = chest.instance()
		inst.position = spawns[j] * 64 - Vector2(-32,-32)
		spawns.remove(j)
		add_child(inst)
		inst.connect("pickedUpRed",self,"increaseEnergy")
	pass

func increaseEnergy():
	$Player.energy+=30
