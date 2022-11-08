extends Spatial

var good: bool

func _process(delta):
	pass

func _plate_entered(body):
	if body.is_in_group("player"):
		if good == true:
			print("is good")
		else:
			print("is bad")
