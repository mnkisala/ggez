extends Spatial

export(String, MULTILINE) var text setget set_text
	
func set_text(text):
	get_node("Label3D").text = text
