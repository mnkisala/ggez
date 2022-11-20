extends Spatial

var questions = [
	["W jaki sposób można dbać o środowisko?", "jeżdżąc na rowerze", "jeżdżąc samochodem"],
	["Do jakiego kosza na śmieci należy wrzucać plastik?", "żółtego", "zielonego"],
	["Co to jest recykling?", "powtórne wykorzystanie odpadów", "zbieranie śmieci w lesie"],
	["Do jakiego kosza na śmieci należy wrzucać szkło?", "zielonego", "żółtego"],
	[
		"Dlaczego kartonowe pudełka należy\nzgniatać przed wyrzuceniem?",
		"żeby zajmowały mniej miejsca na wysypisku",
		"wtedy szybciej sie rozłożą"
	],
	["Do jakiego kosza na śmieci należy wrzucać papier?", "niebieskiego", "żółtego"],
	["Czym są zielone płuca ziemii?", "to lasy", "to największe rzeki"],
	[
		"Co jest przyczyną zanieczyszczenia wody?",
		"wrzucanie do niej odpadów i scieków",
		"rosnące w niej rośliny"
	],
	[
		"Dlaczego należy sadzić drzewa?",
		"ponieważ wchłaniają trujące gazy i dają tlen",
		"ponieważ ładnie wyglądają"
	],
	[
		"Co to jest smog?",
		"zanieczyszczenie powietrza powstałe\nz mgły z dymem i spalinami",
		"dym wylatujący z komina"
	]
]

var active_questions = questions
var question_index

var origin_transform: Transform

var correct_side
var points = 0


func _process(_dt):
	get_node("Player").set_level_specific_text(
		"punkty: %d, pozostalo %d pytan" % [points, questions.size()]
	)

func _exit_tree():
	get_node("Player").set_level_specific_text("")


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
		active_questions = questions  # TODO: clone

	if questions.size() == 0 or points >= 10:
		GameManager.changeScene(LevelEnum.Level.HUB)
	else:
		randomize_question()
		get_node("Player").transform = origin_transform
		print(points)
