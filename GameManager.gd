extends Node

var __level = LevelEnum.Level.HUB

const __ID_TO_LEVEL_PATH = {
	LevelEnum.Level.HUB: "res://Scenes/Levels/Hub.tscn",
	LevelEnum.Level.CHOOSE1: "res://Scenes/Levels/Choose1.tscn",
	LevelEnum.Level.GARGABE_BASE: "res://Scenes/Levels/GarbageBase.tscn",
	LevelEnum.Level.MAZE: "res://Scenes/Levels/Maze.tscn",
	LevelEnum.Level.PARKOUR: "res://Scenes/Levels/Parkour.tscn",
}

const __portalTarget = {
	LevelEnum.Level.HUB: true,
	LevelEnum.Level.CHOOSE1: false,
	LevelEnum.Level.GARGABE_BASE: false,
	LevelEnum.Level.MAZE: false,
	LevelEnum.Level.PARKOUR: false,
}

const __CODE_TO_LEVEL = {
	"1883": LevelEnum.Level.CHOOSE1,
	"3306": LevelEnum.Level.GARGABE_BASE,
	"0443": LevelEnum.Level.MAZE,
	"8080": LevelEnum.Level.PARKOUR
}

func __changeScene(path):
	var err = get_tree().change_scene(path)
	assert(err == OK)


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


func checkCode(code):
	if code in __CODE_TO_LEVEL:
		setPortalTargetActive(__CODE_TO_LEVEL[code], true)
		return true
	else:
		return false
