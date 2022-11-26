extends StaticBody
class_name Kwietnik

const kwiatek = preload("res://Scenes/Interactives/Kwiatek.tscn")

onready var uuid = hash(self.get_path())

func plant():
	var x = (randf() * 2 - 1) * 1.5
	var y = (randf() * 2 - 1) * 0.7
	plant_at(x, y)
	if not (uuid in GameManager.kwietniki):
		GameManager.kwietniki[uuid] = []
	GameManager.kwietniki[uuid].push_back(Vector2(x, y))
	GameManager.player_state.points += 1


func plant_at(x, y):
	var kw = kwiatek.instance()
	kw.transform.origin += Vector3(x, 1.5, y)
	add_child(kw)
	kw.show()

func _ready():
	if uuid in GameManager.kwietniki:
		for kw in GameManager.kwietniki[uuid]:
			plant_at(kw.x, kw.y)
