extends Spatial

var chemicalias_remaining = 0


func _process(_dt):
	if (chemicalias_remaining > 0):
		get_node('player').set_level_specific_text("pozostalo %s chemikaliow do wylaczenia" %  chemicalias_remaining)
	else:
		get_node('player').set_level_specific_text("")
		get_node("Portal").enable()

func _exit_tree():
	get_node('player').set_level_specific_text("")
	GameManager.levels_finished.parkour = true


func _on_ParkourRestartArea_body_entered(body:Node):
	if body is PlayerController:
		GameManager.changeScene(LevelEnum.Level.PARKOUR)
