extends Resource
class_name GarbageRes

export(PackedScene) var model
export(int) var worth

func _init(p_model = null, p_worth = 100):
  model = p_model
  worth = p_worth