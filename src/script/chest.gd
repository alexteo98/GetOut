extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func removeChest():
	get_parent().remove_child(self)
	pass

func _on_redchest_body_entered(body):
	if body.name == "Player":
		removeChest()
		body.increaseEnergy(30)

func _on_greenchest_body_entered(body):
	if body.name == "Player":
		removeChest()
		body.getShield()

func _on_yellowchest_body_entered(body):
	if body.name == "Player":
		removeChest()
		body.increaseScore(50)

func _on_bluechest_body_exited(body):
	if body.name == "Player":
		removeChest()
		body.increaseBaseSpd()
