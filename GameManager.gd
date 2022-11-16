extends Node

var __level = LevelEnum.Level.HUB

const __ID_TO_LEVEL_PATH = {
	LevelEnum.Level.HUB: "res://Scenes/Levels/Hub.tscn",
	LevelEnum.Level.CHOOSE1: "res://Scenes/Levels/Choose1.tscn",
	LevelEnum.Level.GARGABE_BASE: "res://Scenes/Levels/GarbageBase.tscn",
	LevelEnum.Level.MAZE: "res://Scenes/Levels/Maze.tscn",
}

const __portalTarget = {
	LevelEnum.Level.HUB: true,
	LevelEnum.Level.CHOOSE1: true,
	LevelEnum.Level.GARGABE_BASE: true,
	LevelEnum.Level.MAZE: true,
}


func __changeScene(path):
	assert(get_tree().change_scene(path) == OK)


# level - LevelEnum.Level
func changeScene(level):
	if level in __ID_TO_LEVEL_PATH:
		__changeScene(__ID_TO_LEVEL_PATH[level])
	else:
		print("poziom nie istnieje: ", level)


# level - LevelEnum.Level
func setPortalTargetActive(level, active):
	__portalTarget[level] = active


# level - LevelEnum.Level
func isPortalTargetActive(level):
	if level in __portalTarget:
		return __portalTarget[level] == true
	else:
		return false
