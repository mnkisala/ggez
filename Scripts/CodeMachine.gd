tool
extends Spatial
class_name CodeMachine

export(NodePath) var player = null

var active = false
var _can_type = true
var _text = ""
onready var _terminal_label = self.get_node("Matrix/TerminalLabel")


func _set_color(color):
	_terminal_label.modulate = color


func _set_text(text):
	_text = text
	if not _text and _text == "":
		_terminal_label.text = "Wprowadź kod"
	else:
		_terminal_label.text = _text


func handle_input(text):
	if not _can_type:
		return
	if text == "BackSpace":
		if _text.length() > 0:
			_set_text(_text.substr(0, _text.length() - 1))
		return
	if text == "Enter":
		_can_type = false
		var success = GameManager.checkCode(int(_text))
		if success:
			_set_color(Color(0, 1, 0))
			_set_text("Prawidłowy kod")
			get_node(player)._typing = false
			_can_type = false
			active = false
		else:
			_set_color(Color(1, 0, 0))
			_set_text("Błędny kod")
		yield(get_tree().create_timer(1.0), "timeout")
		_can_type = true
		_set_color(Color(1, 1, 1))
		_set_text("")
		return
	if _text.length() < 4:
		_set_color(Color(1, 1, 1))
		_set_text(_text + text)
