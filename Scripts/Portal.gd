extends Spatial

export(LevelEnum.Level) var target = LevelEnum.Level.NULL
var __active = false

const COLOR_ON = Color(0.3, 1.0, 0.1, 0.3)
const COLOR_OFF = Color(1.0, 0.1, 0.2, 0.3)

const BASE_LIGHT = 5.0


func _ready():
	get_node("Particles").process_material = get_node("Particles").process_material.duplicate()

	if GameManager.isPortalTargetActive(target):
		get_node("Particles").process_material.color = COLOR_ON
		get_node("OmniLight").light_color = COLOR_ON
	else:
		get_node("Particles").process_material.color = COLOR_OFF
		get_node("OmniLight").light_color = COLOR_OFF


func _process(dt):
	# mrygansko
	var light = get_node("OmniLight")
	light.light_energy = max(
		0.01, lerp(light.light_energy, BASE_LIGHT + (randf() * 2 - 1.0) * 3.0, dt * 20.0 * randf())
	)


func _on_Area_body_entered(body: Node):
	print("teleportation: ", body, " -> ", target)
	GameManager.changeScene(target)
