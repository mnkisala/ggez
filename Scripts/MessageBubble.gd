extends Spatial

export(String, MULTILINE) var text setget set_text
export(int) var font_size setget set_font_size
	
func set_text(text):
	get_node("Label3D").text = text

func set_font_size(font_size):
	get_node("Label3D").pixel_size = float(font_size) / 100
