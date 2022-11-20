tool
extends Spatial
class_name CodeMachine

var active = false
var _can_type = true
var _text = ""
var _terminal_label

func _ready():
	_terminal_label = get_node("Matrix/TerminalLabel")

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
