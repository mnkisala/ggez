extends Button


func _on_ButtonNewGame_pressed():
	assert(get_tree().change_scene("res://Scenes/Scene1.tscn") == OK)
