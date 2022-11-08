extends Spatial

export(String) var text setget set_text
	
func set_text(text):
	get_node("Label3D").text = text
