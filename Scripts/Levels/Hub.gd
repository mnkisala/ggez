extends Spatial

func _ready():
	GameManager.update_portals()
	var tree
	match GameManager.get_tree_stage():
		1:
			tree = get_node("treeFirstStage")
		2:
			tree = get_node("treeSecondStage")
		3:
			tree = get_node("treeThirdStage")
		4:
			tree = get_node("treeFourthStage")
		5:
			tree = get_node("streecomplete")
			get_node("roof_closed").visible = false
			get_node("roof_open").visible = true
	tree.visible = true
