extends Spatial

export(int) var font_size setget set_font_size

func set_text(new_text):
	get_node("Label3D").text = new_text
	
func set_font_size(new_font_size):
	get_node("Label3D").pixel_size = float(new_font_size) / 100
