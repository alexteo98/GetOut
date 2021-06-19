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


func _on_redchest_area_entered(area):
	if (area.name == "Player"):
		queue_free()
	pickedUp()
	removeChest()
	pass # Replace with function body.

func pickedUp():
	print("debug")
	emit_signal("pickedUpRed",30)

func removeChest():
	remove_child(self)
	pass
