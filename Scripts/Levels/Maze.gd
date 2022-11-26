extends Spatial

func _exit_tree():
	GameManager.levels_finished.maze = true
