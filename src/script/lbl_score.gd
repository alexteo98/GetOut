extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	game.connect("score_current_changed", self, "_on_score_current_changed")
	set_text(str(game.score_current))
	pass # Replace with function body.

func _on_score_current_changed():
	set_text(str(game.score_current))
	pass

