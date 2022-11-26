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
	for g in GameManager.garbage_collected:
		if self.uuid == g:
			hide()
			queue_free()
