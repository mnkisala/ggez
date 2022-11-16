extends Spatial

export(LevelEnum.Level) var target = LevelEnum.Level.NULL
var __active = false

func _ready():
	get_node("Particles").process_material = get_node("Particles").process_material.duplicate()

	if GameManager.isPortalTargetActive(target):
		get_node("Particles").process_material.color = Color(0, 1.0, 0, 0.15)
		get_node("OmniLight").light_color = Color(0, 1.0, 0, 0.15)
	else:
		get_node("Particles").process_material.color = Color(1.0, 0.0, 0, 0.15)
		get_node("OmniLight").light_color = Color(1.0, 0, 0, 0.15)


func _on_Area_body_entered(body:Node):
	print("teleportation: ", body, " -> ", target)
	GameManager.changeScene(target)
