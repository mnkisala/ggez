extends Spatial


func _ready():
	if GameManager.easter_egg == false:
		hide()
