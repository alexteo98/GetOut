extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal wall_collision

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_wall_left_area_entered(area):
	if area.name == "head":
		queue_free()
		emit_signal("wall_collision")
	pass # Replace with function body.


func _on_wall_right_area_entered(area):
	if area.name == "head":
		queue_free()
		emit_signal("wall_collision")
	pass # Replace with function body.


func _on_wall_top_area_entered(area):
	if area.name == "head":
		queue_free()
		emit_signal("wall_collision")
	pass # Replace with function body.


func _on_wall_bottom_area_entered(area):
	if area.name == "head":
		queue_free()
		emit_signal("wall_collision")
	pass # Replace with function body.
