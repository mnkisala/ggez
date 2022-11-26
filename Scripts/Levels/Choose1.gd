extends Spatial

var questions = [
	["Docelowe zaprzestanie emisji CO2 do \n atmosfery w polityce ochrony środowiska to:", 
		"Dekarbonizacja", 
		"Karbonizacja"],
	["Do jakiego kosza na śmieci należy wrzucać plastik?", "żółtego", "zielonego"],
	["Co to jest recykling?"
		, "powtórne wykorzystanie odpadów"
		, "nie wykorzystywanie odpadów powtórnie"],
	["Do jakiego kosza na śmieci należy wrzucać szkło?"
		, "zielonego"
		, "żółtego"],
	[
		"Minimalna odległość elektrowni wiatrowej \n od najbliższego budynku mieszkalnego wynosi: ",
		"2 km",
		"20 km"
	],
	["Do jakiego kosza na śmieci należy wrzucać papier?", 
		"niebieskiego", 
		"żółtego"],
	["Model ekonomiczny polegający na m.in na recyklingu, \n naprawie i odnawianiu,\n który wydłuża cykl życia produktów, \n czyli ogranicza nam odpady do minimum.",
		"Gospodarka o obiegu zamkniętym ", 
		"Planowana zużywalność "],
	[
		"Na czym polega neutralność emisyjna:",
		"Zmiejszenie emisji CO2, do takiego stopnia, \n że wraz wyprodukowaniem go \n będziemy pochłaniać taką samą ilość ",
		"Zaprzestaniemy produkować w ogóle CO2 "
	],
	[
		"Ile rocznie naturalne pochłaniacze CO2 (m.in:  gleba, lasy) \n pochłaniają dwutlenku węgla: ",
		"do 11 gigaton",
		"do 36 gigaton"
	],
	[
		"Na którym miejscu na świecie znajduje  \n się UE pod względem emisji CO2:",
		"3",
		"8"
	],
	[
		"Możliwość swobodnego poruszania się bez paszportu \n w większości państw europy daje nam :",
		"Strefa Szengen",
		"Strefa Wolna"
	],
	[
		"Do którego roku Unia Europejska osiągnie \n zerowy poziom emisji gazów cieplarnianych netto: ",
		"2050",
		"2060"
	],
	[
		"Przyszłość unijnej polityki czystego powietrza w ramach \n dążenia do osiągnięcia zerowego poziomu emisji \n zanieczyszczeń opinia ta została opracowana przez:",
		"János Ádám Karácsony",
		"Charles Michel"
	],
	[
		"W 2020 został zawiązany sojusz na rzecz pewnego \n pierwiastku, który pomoże w dekarbonizajci przemysłu \n oraz w promowaniu tego pierwiastka. Jest nim :",
		"Wodór",
		"Argon"
	],
	[
		"Czysta energia (m.in rozpoczęcie wykorzystywania wodoru \n w większej skali), czysty przemysł oraz oszczędzanie \n energi są to przedsięwzięcia zawarte w :",
		"REPowerEU",
		"PowerForAll"
	]
]

var active_questions = [] + questions
var question_index

var origin_transform: Transform

var correct_side
var points = 0


func _process(_dt):
	get_node("Player").set_level_specific_text(
		"punkty: %d/%d" % [points, 10]
	)
	#debug
	if Input.is_action_just_pressed("debug"):
		print("debug")
		get_node("LeftPlate").disable()
		get_node("RightPlate").disable()
		get_node("Sign/Label3D").text = "Udało ci się odpowiedzieć na wszystkie pytania,\nkod to 2131"
		get_node("HubPortal").enable()

func _exit_tree():
	get_node("Player").set_level_specific_text("")
	GameManager.levels_finished.choose1 = true


func _randi_range(from, to):
	randomize()
	return floor(rand_range(from, to + 1))


func _ready() -> void:
	origin_transform = get_node("Player").transform
	randomize_question()

func randomize_question():
	var left_anwser = get_node("LeftPlate/Answer")
	var right_answer = get_node("RightPlate/Answer")
	var _sign = get_node("Sign/Label3D")
	question_index = _randi_range(0, active_questions.size() - 1)
	_sign.text = active_questions[question_index][0]
	if _randi_range(0, 1) == 0:
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
		if points > 0:
			points -= 1
		active_questions = [] + questions

	if questions.size() == 0 or points >= 10:
		get_node("LeftPlate").disable()
		get_node("RightPlate").disable()
		get_node("Sign/Label3D").text = "Udało ci się odpowiedzieć na wszystkie pytania,\nkod to 2131"
		get_node("HubPortal").enable()
	else:
		randomize_question()
		get_node("Player").transform = origin_transform
