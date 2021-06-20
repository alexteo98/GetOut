extends Area2D

signal pickedUpRed

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
	remove_child(self)
	pass

func _on_redchest_body_entered(body):
	if body.name == "Player":
		queue_free()
		removeChest()
		body.increaseEnergy(30)

