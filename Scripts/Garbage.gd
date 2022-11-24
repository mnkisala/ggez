extends RigidBody
class_name Garbage

enum Kind {
	Paper,
	Glass,
	Plastic,
}

export(int) var points = 0
export(Kind) var kind = null
export(Texture) var preview = null

onready var uuid = hash(self.get_path())


func _ready():
	for g in GameManager.player_state.garbage_bag:
		if self.uuid == g.uuid:
			hide()
			queue_free()
