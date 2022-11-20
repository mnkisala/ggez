extends RigidBody
class_name Garbage

enum Kind {
	Paper,
	Glass,
	Plastic,
} 

export(int) var points = 0
export(Kind) var kind = null