extends Node

var _player_state = null

func player_state():
	return _player_state

func _init():
	_player_state = PlayerState.new()
	pass
