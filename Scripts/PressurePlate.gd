extends Spatial

var side: String

func _process(delta):
	pass

func _ready():
	get_node("Answer/Label3D").get_font().size = 64

func _plate_entered(body):
	if body.is_in_group("player"):
		get_node("/root/Choose1").trigger_anwser(side)
