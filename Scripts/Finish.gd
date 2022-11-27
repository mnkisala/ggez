extends Control

func _ready():
	var label = get_node("Label")
	label.set_text("Gratulacje ukończenia gry!\nTwoje zdobyte punkty to: " + str(GameManager.player_state.points) + "\nPrzejdź na LNU aby dokończyć misję.")
