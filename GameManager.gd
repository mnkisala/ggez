extends Node

var __level = LevelEnum.Level.HUB

const __ID_TO_LEVEL_PATH = {
	LevelEnum.Level.HUB: "res://Scenes/Levels/Hub.tscn",
	LevelEnum.Level.CHOOSE1: "res://Scenes/Levels/Choose1.tscn",
	LevelEnum.Level.GARGABE_BASE: "res://Scenes/Levels/GarbageBase.tscn",
	LevelEnum.Level.MAZE: "res://Scenes/Levels/Maze.tscn",
	LevelEnum.Level.PARKOUR: "res://Scenes/Levels/Parkour.tscn",
	LevelEnum.Level.FINISH: "res://Scenes/Levels/Finish.tscn",
}

var levels_finished = {
	choose1 = false,
	maze = false,
	parkour = false,
	garbage = false
}

const __CODE_TO_PORTAL = {1883: 2, 3306: 3, 1080: 4, 8080: 5}

const portals = {}
var enabled_portals = []

var easter_egg = false

onready var player_state = PlayerState.new()
var garbage_collected = []
var kwietniki = {}


func get_tree_stage():
	var tree_stage = 1
	for i in levels_finished:
		if levels_finished[i] == true:
			tree_stage = tree_stage +1
	return tree_stage


func update_portals():
	for portal_id in enabled_portals:
		var portal = portals[portal_id]
		portal.enable()


func __changeScene(path):
	var err = get_tree().change_scene(path)
	assert(err == OK)


# level - LevelEnum.Level
func changeScene(level):
	if level in __ID_TO_LEVEL_PATH:
		__changeScene(__ID_TO_LEVEL_PATH[level])
	else:
		print("poziom nie istnieje: ", level)


func registerPortal(id, portal):
	portals[id] = portal


func checkCode(code):
	if code == 5287:
		easter_egg = true
		get_node("/root/hub/Secret").show()
		return true
	if code in __CODE_TO_PORTAL:
		var portal_id = __CODE_TO_PORTAL[code]
		var portal = portals[portal_id]
		portal.enable()
		enabled_portals += [portal_id]
		return true
	else:
		return false
