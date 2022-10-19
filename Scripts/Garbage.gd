tool
extends Spatial

export(Resource) var resource = null setget _resource_set, _resource_get

var scene

func _ready():
	if (resource != null):
		scene = resource.model.instance()
		self.add_child(scene)


func _resource_set(v):
	resource = v
	self.remove_child(scene)
	if (resource != null):
		scene = resource.model.instance()
		self.add_child(scene)

func _resource_get():
	return resource
