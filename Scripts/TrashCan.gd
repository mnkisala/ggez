extends Spatial

export(Garbage.Kind) var kind;

func _ready():
	var _idk = $"Area".connect("body_entered", self, "_on_Area_body_entered")

func _on_Area_body_entered(body:Node):
	if body is Garbage:
		if body.kind == kind:
			GameManager.player_state.points += body.points
		else:
			GameManager.player_state.points -= body.points

		body.get_parent().remove_child(body)
		body.queue_free()

		print("points: ", GameManager.player_state.points)