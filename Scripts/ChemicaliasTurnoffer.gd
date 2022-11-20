extends StaticBody
class_name ChemicaliasTurnoffer

export(NodePath) var chemicalias_emmiter

var turned_off = false


func _ready():
	get_node("/root/Parkour").chemicalias_remaining += 1


func turn_off_chemicalias():
	if not turned_off:
		var chemicalias = get_node(chemicalias_emmiter)
		var particles = chemicalias.get_node("Particles")
		particles.emitting = false

		get_node("/root/Parkour").chemicalias_remaining -= 1

		turned_off = true
