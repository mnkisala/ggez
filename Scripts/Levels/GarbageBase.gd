extends Spatial

func _exit_tree():
	get_node('player').set_level_specific_text("")


func _process(_dt):
	get_node('player').set_level_specific_text("punkty: %d" %  GameManager.player_state.points)