extends StaticBody
class_name Kwietnik

const kwiatek = preload("res://Scenes/Interactives/Kwiatek.tscn")

func plant():
	var kw = kwiatek.instance()
	kw.transform.origin += Vector3((randf() * 2 - 1) * 1.5, 1.5, (randf() * 2 - 1) * 0.7)
	add_child(kw)
	kw.show()
	pass


func _ready():
	pass
