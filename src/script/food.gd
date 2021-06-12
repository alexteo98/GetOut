extends Area2D

signal food_eaten

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_item_area_entered(area):
	if (area.name == "head"):
		queue_free()
		emit_signal("food_eaten")
	pass # Replace with function body.
