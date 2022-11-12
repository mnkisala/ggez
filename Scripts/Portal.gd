extends Spatial

var id = -1
var __active = false

func _ready():
	get_node("Particles").process_material = get_node("Particles").process_material.duplicate()
	var game_manager = get_node("/root/GameManager")
	game_manager.registerPortal(self)

func setActive(active):
	__active = active
	if __active == true:
		get_node("Particles").process_material.color = Color(0, 1.0, 0, 0.15)
	else:
		get_node("Particles").process_material.color = Color(1.0, 0, 0, 0.15)
