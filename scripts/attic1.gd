extends Node2D

@export var nodesToRemove:Array[Node2D]
@export var nodesToAdd:Array[Node2D]
var parentOfNodes:Array[Node2D]
var nearLadder:bool=false

#text_box is autoloaded since im using it in every lvl
@onready var textBox :textBoxClass = get_node("/root/text_box")

#after sleeping, reset character sprite and position
#entering and reeantering the attic logic
func _ready():
	removeAddNodes()
	match self.name:
		"attic1":
			if globals.firstTime(self.name):
				globals.getPlayer().position=Vector2(161,234)
				globals.getPlayer().animationReset()

			if globals.npcTriggered.has("potato") and globals.npcTriggered["potato"]:
				removeNodes()
				addNodes()
				if globals.npcTriggered.has("rat") and globals.npcTriggered["rat"]:
					globals.npcRef["rat"].queue_free()
		"attic2":
			if globals.firstTime(self.name):
				globals.getPlayer().position=Vector2(161,234)
				globals.getPlayer().animationReset()

			if globals.npcTriggered.has("beans") and globals.npcTriggered["beans"]:
				removeNodes()
				addNodes()
				if globals.npcTriggered.has("rat2") and globals.npcTriggered["rat2"]:
					globals.npcRef["rat2"].queue_free()
				if globals.npcTriggered.has("cat") and globals.npcTriggered["cat"]:
					globals.npcRef["cat"].queue_free()
		"attic3":
			if globals.firstTime(self.name):
				globals.getPlayer().position=Vector2(1110,366)
				globals.getPlayer().animationReset()

			if globals.npcTriggered.has("knife") and globals.npcTriggered["knife"]:
				removeNodes()
				addNodes()

func _process(delta):
	match self.name:
		"attic3":

			if globals.npcTriggered["flapjack"]==true:
				globals.npcRef["flapjack"].get_child(1).play("crying")

			if globals.npcTriggered["flapjack2"]==true and text_box.current_state==text_box.State.ready:
				globals.npcRef["flapjack2"].get_child(1).play("noHead")
				globals.getPlayer().changeMode("EatFlapjack")


#before
func removeNodes():
	for node in nodesToRemove:
		globals.removeNode(node)

func removeAddNodes():
	for node in nodesToAdd:
		parentOfNodes.push_front(node.get_parent())
		globals.removeNode(node)

#after
func addNodes():
	for node in nodesToAdd:
		#add nodes to the scene
		parentOfNodes[nodesToAdd.find(node)].add_child(node)
		if globals.npcRef.has(node.name):
			globals.npcRef[node.name]=node
"""
⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠉⠉⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣿⣿⣿⡿⠃⠁⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣿⣿⡯⢠⡞⣱⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣿⠿⣠⠟⣰⣿⣿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⢿⣽⠇⢠⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠈⣿⣿⣿⣿⣿⡏⣿⣿⣿⣿⢹⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣾⠁⣴⣿⡏⡿⣼⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⢻⣿⣿⣿⣯⡇⢸⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⡿⢁⣾⡝⢹⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⢸⣿⣿⡿⠻⣀⣘⣛⣛⣛⠳⠿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⡿⢁⡾⢃⣷⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⠈⡇⣿⣿⣿⣿⣿⣿⣿⠿⠃⠀⠀⡼⢋⣡⡾⠟⠛⠉⠛⣟⠿⣿⣦⣸⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠳⡄⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⢃⣾⠁⢸⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⠀⠹⠹⡿⠿⠛⠛⠋⠁⠀⠀⠀⠀⠀⢞⣿⣄⡠⠶⠦⠤⠬⠤⠼⠛⣻⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠹⡄⠀⠀⠀⠀⠀⠀⠀
⣿⠃⣼⠗⠀⣿⣿⣿⣿⣿⣿⣿⣿⠀⠻⣿⣿⣿⣿⠿⠟⠛⢳⡶⣤⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠀⠀⠀⠀ ⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⡜⢧⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀
⡏⢸⡟⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⡇⢀⣾⡿⡏⠁⠀⣠⡤⠔⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⢀⣾⡇⣿⡟⣿⣿⣿⣿⣿⣿⡇⠈⢧⡀⠀⠘⣄⠀⠀⠀⠀⠀
⠀⡟⡀⠀⠀⣿⢹⣿⣿⣿⣿⣿⣿⣇⣿⣯⣀⣷⠶⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⣹⠟⢀⣿⠁⣿⣿⣿⣿⣿⣿⣿⠀⠈⢳⡄⠀⠙⡄⠀⠀⠀⠀
⢸⡏⠁⠀⠀⣿⢸⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠈⠁⠀⢸⡟⠀⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⢻⡄⠀⢱⠀⠀⠀⠀
⢸⣴⡀⠀⠀⣿⢸⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⢀⡟⠁⠀⡇⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠹⣆⠀⠇⠀⠀⠀
⢈⣸⡔⠀⠀⣿⡞⣿⣿⣿⣿⣿⣿⣻⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠔⠋⠀ ⠀⢸⡯⣿⣯⣿⣿⣿⣿⡇⠀⠀⠀⠀⠹⣆⠀⠀⠀⠀
⠚⡥⣄⠀⠀⢻⡇⣿⣿⣿⣿⣿⣿⣧⠻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠖⢒⣉⣭⣭⣕⣲⣤⠖⠒⠀⠀⠀⠀⠀⠀⢸⠁⣿⣟⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠘⣧⠀⠀⠀
⠰⠛⠁⠀⠀⠘⣷⣿⣿⣿⣿⣿⣿⡝⣦⣱⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣰⣞⣷⠿⠛⠋⢉⣠⢟⡋⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⢉⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠘⣧⠀⠀
⠠⢀⠠⠀⠀⠀⢿⡟⣿⣿⣿⣿⣿⣷⠈⠳⣿⡄⠀⠀⠀⠀⠀⠀⠀⠈⠉⠙⠛⣿⣿⢿⢵⠛⠁⠀⠀⠀⢠⠖⠛⡏⠀⠀⣼⠃⣸⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠘⣧⠀
⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⠳⣄⠀⠽⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡏⠙⣿⠀⢧⠀⠀⠀⢠⠏⠀⢸⠁⢀⣼⡿⠋⣙⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠘⣧
⠠⠀⠁⠀⠀⣰⠃⢻⣿⣿⣿⣿⣿⣿⣇⠈⠓⠦⣬⣧⡄⠀⠀⠀⠀⠀⠀⠀⠀⠻⡀⢹⡀⠀⢧⠀⠀⢸⠀⠀⢿⣠⣿⠏⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠘
⠀⠀⠀⠀⢠⢏⠀⢈⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠙⠦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠙⣄⢧⠀⠈⢳⡀⢸⠀⠀⢺⣿⠃⠀⢰⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀
⠠⠀⠀⠀⡞⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠈⠙⢲⣦⣄⣀⣀⠀⠀⠀⠈⢫⣆⠀⠀⢳⣾⠀⠀⢸⠇⠀⠀⣾⣿⣿⣿⣿⣿⣿⡿⠘⣿⣿⣿⣇⢀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡼⠁⠀⢀⣿⣿⡿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⣀⠀⠀⢻⡀⠙⠛⠿⢿⣿⣶⣶⣿⣄⠀⠀⢹⠀⠀⢸⠀⠀⢠⣿⣿⣻⣿⣿⣿⣿⠇⠀⢹⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀
⠀⠀⣼⠁⠀⠀⣸⣿⣿⠃⢻⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠰⡄⢠⡾⠳⠤⣄⣀⠀⠀⠈⠉⠉⠙⢦⠀⢸⠀⠀⠈⡆⠀⣾⢟⣽⣿⣿⣿⣿⡟⠀⠀⠈⢿⣿⣿⣷⠀⠀⠀⠀⠀⠀
⢀⡾⠃⠀⠀⢠⣿⣿⡏⠀⠀⢻⣿⣿⣿⣿⣿⣿⣆⠀⠀⣰⢸⡁⣸⠃⠀⠀⠀⠉⠙⠒⠤⣤⣀⢀⣬⣷⣾⠀⠀⠀⢇⢰⣻⣿⣿⣿⣿⠟⠈⠀⠀⠀⠀⠘⢿⣿⣿⣧⠀⠀⠀⠀⠀
⡿⠁⠀⠀⢠⣿⣿⡟⠀⠀⡀⠀⠙⣿⣿⣿⣿⣿⣿⣷⣤⡿⣾⣷⡿⠀⠀⡖⠒⢦⡀⠀⠀⢀⡼⠉⢧⣷⡇⠀⠀⠀⠸⡟⠉⢿⡛⠛⠉⡀⠀⠀⠸⣆⣀⠀⠈⣿⣿⣿⣆⠀⠀⠀⠀
⠀⠀⠀⢠⣿⣿⡟⠁⡤⠀⡠⣠⣿⡈⠻⢿⣿⣿⣿⣿⣿⣱⣿⣿⡇⠀⠀⢣⠀⠀⠙⢆⣠⠏⠫⠠⢐⢿⠇⠀⠀⠀⠀⢻⠀⢸⣷⡔⠀⡐⠂⡀⣀⣿⣿⡆⠀⢨⢿⣿⣿⣆⠀⠀⠀
⠀⠀⣠⣿⣿⣟⢮⣚⣠⣍⣶⣟⣿⣷⡤⣀⣉⣷⣟⣿⣿⣿⣿⣿⠀⠀⠀⠈⢧⡀⣠⢼⣿⣷⣶⣠⡾⡏⠀⠀⠀⠀⠀⢸⠀⠀⣿⣿⣿⣥⣌⡳⣦⣾⣷⣻⣶⢬⣝⣿⣿⣿⣆⠀⠀
⢀⣴⣿⣿⣿⣿⣿⣿⣾⣿⣯⣾⠿⠿⢿⣿⣿⣯⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⢀⣿⡗⠉⠀⠻⣿⡝⢀⠇⠀⠀⠀⠀⠀⡾⠀⠀⢸⣿⣿⣿⣿⠿⠬⢿⣿⣷⣝⣿⣯⣿⣿⣿⣿⣧⡀
⣾⡿⠟⠛⠋⠉⠀⠀⠀⠉⠉⠉⠛⠒⠀⡀⣠⣿⣿⣿⣿⣿⣿⣄⣀⣀⡤⠒⠉⢀⣷⠀⠀⠀⠀⠀⡼⠀⠀⠀⠀⠀⢠⠧⣄⠀⠈⢿⣿⣿⣿⣷⡄⠈⠉⠀⠉⠉⠁⠉⠉⠉⠉⠙⠛
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⢀⣨⣶⣿⣿⡇⠀⠀⠀⡸⠁⠀⠀⠀⠀⠀⢸⣄⠈⠉⠉⠹⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⡿⠀⠀⣀⣴⣿⣿⣿⣿⠿⢻⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣷⣄⡀⠀⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⠃⢴⣾⣿⣿⣿⡿⠛⠁⠀⠈⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⢛⠿⣿⣿⣿⠦⢸⣿⣿⣿⣿⣿⣿⣿⣆⡀⠀⠀⠀⠀⠀⠀⠀
"""
