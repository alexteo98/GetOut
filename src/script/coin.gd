extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")
	pass # Replace with function body.

func _on_body_entered(other_body):
	if other_body.is_in_group(game.GROUP_BIRDS):
		game.score_current +=1
		sounds.find_node("sfx_point").play()
	pass
