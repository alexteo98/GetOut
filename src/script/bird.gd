extends RigidBody2D

onready var state = FlyingState.new(self)

const TARGET_SCORE = 5
const STATE_FLYING		= 0
const STATE_FLAPPING	= 1
const STATE_HIT			= 2
const STATE_GROUNDED	= 3
var speed = 50
#var prev_state = STATE_FLAPPING
signal state_changed

func _ready():
	set_process_input(true)
	set_physics_process(true)
	add_to_group(game.GROUP_BIRDS)
	connect("body_entered", self, "_on_body_entered")
	pass 

func _process(delta):
	if game.score_current >= TARGET_SCORE:
		get_tree().set_screen_stretch(1,1,Vector2(1024,600),1)
		get_parent().get_parent().resume()
		var parent = get_parent().get_parent()
		var remove = parent.get_child(parent.get_child_count()-1)
		parent.remove_child(remove)
		

func restart():
	game._set_score_current(0)
	var parent = get_parent().get_parent()
	var target = parent.get_child(parent.get_child_count()-1)
	parent.remove_child(target)
	parent.startFlappy()

func _on_body_entered(other_body):
	if state.has_method("on_body_entered"):
		state.on_body_entered(other_body)
	pass

func _physics_process(delta):
	state.update(delta)
	pass

func _input(event):
	state.input(event)
	pass

func set_state(new_state):
	#prev_state = get_state()
	state.exit()
	if new_state == STATE_FLYING:
		state = FlyingState.new(self)
	elif new_state == STATE_FLAPPING:
		state = FlappingState.new(self)
	elif new_state == STATE_HIT:
		state = HitState.new(self)
	elif new_state == STATE_GROUNDED:
		state = GroundedState.new(self)
	emit_signal("state_changed", self)
	pass

func get_state():
	if state is FlyingState:
		return  STATE_FLYING
	elif state is FlappingState:
		return  STATE_FLAPPING
	elif state is HitState:
		return  STATE_HIT
	elif state is GroundedState:
		return  STATE_GROUNDED

#_____________________________________________________________________________
class FlyingState:
	var bird
	var prev_gravity_scale
	 
	func _init(bird):
		print("FLYING")
		self.bird = bird
		bird.get_node("anim").play("Flying")
		bird.set_linear_velocity(Vector2(bird.speed,bird.get_linear_velocity().y))
		
		prev_gravity_scale = bird.get_gravity_scale()
		bird.set_gravity_scale(0)
		pass
	
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		bird.set_gravity_scale(prev_gravity_scale)
		bird.get_node("anim").stop()
		bird.get_node("anim_sprite").set_position(Vector2(0,0))
		pass

#_____________________________________________________________________________
class FlappingState:
	var bird

	func _init(bird):
		self.bird = bird
		bird.set_linear_velocity(Vector2(bird.speed,bird.get_linear_velocity().y))
		flap()
		pass
	
	func update(delta):
		if bird.rotation < deg2rad(-30):
			bird.rotation = deg2rad(-30)
			bird.set_angular_velocity(0)
		if bird.get_linear_velocity().y > 0:
			bird.set_angular_velocity(1.5)
	pass
	
	func input(event):
		if event.is_action_pressed("flap"):
			flap()
			print("FLAP")
		pass
	
	func on_body_entered(other_body):
		if other_body.is_in_group(game.GROUP_PIPES):
			bird.set_state(bird.STATE_HIT)
		elif other_body.is_in_group(game.GROUP_GROUNDS):
			bird.set_state(bird.STATE_GROUNDED)
		pass
	
	func flap():
		bird.set_linear_velocity(Vector2(bird.get_linear_velocity().x,-125))
		bird.set_angular_velocity(-3)
		bird.get_node("anim").play("Flap")
		sounds.find_node("sfx_wing").play()
		pass
	
	func exit():
		pass
#_____________________________________________________________________________
class HitState:
	var bird
	
	func _init(bird):
		print("HIT")
		self.bird = bird
		bird.set_linear_velocity(Vector2(0,0))
		bird.set_angular_velocity(2)
		var other_body = bird.get_colliding_bodies()[0]
		bird.add_collision_exception_with(other_body)
		sounds.find_node("sfx_hit").play()
		sounds.find_node("sfx_die").play()
		pass
	
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass
	
	func on_body_entered(other_body):
		if other_body.is_in_group(game.GROUP_GROUNDS):
			bird.set_state(bird.STATE_GROUNDED)
		pass
	
	func flap():
		print("cant flap")
		pass
#_____________________________________________________________________________
class GroundedState:
	var bird
	signal end_game
	
	func _init(bird):
		print("GROUNDED")
		self.bird = bird
		bird.set_linear_velocity(Vector2(0,0))
		bird.set_angular_velocity(0)
		sounds.find_node("sfx_hit").play()
		bird.restart()
		pass
	
	
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass
	
	func flap():
		print("cant flap")
		pass
