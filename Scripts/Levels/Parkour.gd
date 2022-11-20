extends Spatial

var chemicalias_remaining = 0


func _process(_dt):
	get_node('player').set_level_specific_text("pozostalo %s chemikaliow do wylaczenia" %  chemicalias_remaining)

