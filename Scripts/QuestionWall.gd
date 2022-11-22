extends Spatial

export(String, MULTILINE) var question setget set_question
	
func set_question(question):
	get_node("Sign").set_text(question)
