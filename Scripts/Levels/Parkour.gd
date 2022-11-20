extends Spatial

var chemicalias_remaining = 0


func _process(_dt):
	get_node('player').set_level_specific_text("pozostalo %s chemikaliow do wylaczenia" %  chemicalias_remaining)

func _exit_tree():
	get_node('player').set_level_specific_text("")


func _on_ParkourRestartArea_body_entered(body:Node):
	if body is PlayerController:
		GameManager.changeScene(LevelEnum.Level.PARKOUR)
