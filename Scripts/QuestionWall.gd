extends Spatial
class_name QuestionWall

export(String, MULTILINE) var question setget set_question
export(bool) var right_correct_anwser = true


func _ready():
	_set_correct_anwser(right_correct_anwser)


func set_question(q):
	get_node("Sign").set_text(q)


func _set_correct_anwser(correct):
	if correct:
		get_node("QuestionRightButton").correct = true
	else:
		get_node("QuestionLeftButton").correct = true


func disable():
	visible = false
	set_process(false)
	get_parent().remove_child(self)
	get_node("QuestionLeftButton/CollisionShape").disabled = true
	get_node("QuestionRightButton/CollisionShape").disabled = true
