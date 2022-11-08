extends Spatial

var questions = [
	[
		"pytanie",
		"odp1",
		"odp2"
	],
	[
		"pytanie2",
		"odp1",
		"odp2"
	]
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var asdf = get_node("Sign")
	asdf.get_node("Label3D").text = questions[0][0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
