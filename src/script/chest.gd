extends Area2D

func _ready():
	pass

func removeChest():
	queue_free()

func _on_redchest_body_entered(body):
	if body.name == "Player":
		body.increaseEnergy(30)
		playSound()
		removeChest()

func _on_greenchest_body_entered(body):
	if body.name == "Player":
		body.getShield()
		playSound()
		removeChest()

func _on_yellowchest_body_entered(body):
	if body.name == "Player":
		body.increaseScore(50)
		#playSound()
		sounds.find_node("sfx_point").play()
		removeChest()

func _on_bluechest_body_exited(body):
	if body.name == "Player":
		body.increaseBaseSpd()
		playSound()
		removeChest()

func playSound():
	sounds.find_node("sfx_item_collected").play()
