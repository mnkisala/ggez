extends Node

var __level = 1
var __hubScene = "res://Scenes/Levels/Hub.tscn"

var activePortals = []

func __changeScene(path):
	assert(get_tree().change_scene(path) == OK)

func registerPortal(portal):
	activePortals.append(portal)
	portal.id = activePortals.size()
	if portal.id <= __level:
		portal.setActive(true)
