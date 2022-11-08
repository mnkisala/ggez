extends Spatial

var questions = [
	[
		"pytanie1",
		"dobra",
		"zla"
	],
	[
		"pytanie2",
		"dobra",
		"zla"
	]
]

var active_questions = questions
var question_index

var origin_transform: Transform

var correct_side
var points = 0

func randi_range(from, to):
	randomize()
	return floor(rand_range(from, to + 1))

func _ready() -> void:
	origin_transform = get_node("Player").transform
	randomize_question()

func randomize_question():
	var left_anwser = get_node("LeftPlate/Answer")
	var right_answer = get_node("RightPlate/Answer")
	var _sign = get_node("Sign/Label3D")
	question_index = randi_range(0, active_questions.size() - 1)
	_sign.text = active_questions[question_index][0]
	if randi_range(0, 1) == 0:
		correct_side = "left"
		left_anwser.text = active_questions[question_index][1]
		right_answer.text = active_questions[question_index][2]
	else:
		correct_side = "right"
		left_anwser.text = active_questions[question_index][2]
		right_answer.text = active_questions[question_index][1]

func trigger_anwser(side):
	if side == correct_side:
		points = points + 1
		active_questions.pop_at(question_index)
	else:
		points = 0
		active_questions = questions # TODO: clone
	randomize_question()
	get_node("Player").transform = origin_transform
	print(points)
