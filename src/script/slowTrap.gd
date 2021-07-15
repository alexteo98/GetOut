extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_slowTrap_body_entered(body):
	if body.name == "Player":
		get_node("anim").play("activate")
		body.slowDown()
		yield(get_tree().create_timer(1.0), "timeout")
		queue_free()
	pass # Replace with function body.
