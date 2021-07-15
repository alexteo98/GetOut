extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("anim").play("activate")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_spikeTrap_body_entered(body):
	if body.name == "Player":
		body.hit()
		pass # Replace with function body.
