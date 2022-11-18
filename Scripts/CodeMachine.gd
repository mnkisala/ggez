tool
extends Spatial
class_name CodeMachine

var active = false
var _text = ""

func _set_text(text):
	var terminal_label = get_node("Matrix/TerminalLabel")
	_text = text
	if not _text and _text == "":
		terminal_label.text = "Wprowadź kod"
		terminal_label.modulate = Color(0.75, 0.75, 0.75)
	else:
		terminal_label.text = _text
		terminal_label.modulate = Color(1, 1, 1)

func handle_input(text):
	if text == "BackSpace":
		if _text.length() > 0:
			_set_text(_text.substr(0, _text.length() - 1))
		return
	if text == "Enter":
		return
	if _text.length() < 4:
		_set_text(_text + text)
