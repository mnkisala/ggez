extends Spatial

func _exit_tree():
	get_node("player").set_level_specific_text("")
	GameManager.levels_finished.garbage = true

func _process(_dt):
	get_node("player").set_level_specific_text("punkty: %d" % GameManager.player_state.points)
	if GameManager.player_state.garbage_bag.size() > 0:
		get_node("Control").visible = true
		get_node("Control/GridContainer/TextureRect").texture = GameManager.player_state.garbage_bag[-1].preview
	else:
		get_node("Control").visible = false
		get_node("Portal").enable()
		get_node("player").set_level_specific_text("punkty: %d" % GameManager.player_state.points)
