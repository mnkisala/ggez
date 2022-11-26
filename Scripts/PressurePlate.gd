extends Spatial

var side: String
var enabled: bool = true

func _plate_entered(body):
	if body.is_in_group("player") and enabled:
		get_node("/root/Choose1").trigger_anwser(side)

func disable():
	enabled = false
	visible = false
