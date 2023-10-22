extends Node2D

@export var nodesToRemove:Array[Node2D]
@export var nodesToAdd:Array[Node2D]
var parentOfNodes:Array[Node2D]
var advanceLvl:bool=false

# Called when the node enters the scene tree for the first time.
func _ready():
	if globals.firstTime(self.name):
		globals.npcTriggered["advanceLvl"]=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match self.name:
		"home1":
			if globals.npcTriggered.has("potato") and globals.npcTriggered["potato"]==true and !globals.npcTriggered["advanceLvl"]:
				if globals.npcRef["potato"].visible:
					globals.getPlayer().changeMode("EatPotato")
				globals.npcRef["potato"].visible=false

				if globals.getPlayer().inAnimation==false:
					globals.npcTriggered["potato"]=false
					globals.npcTriggered["advanceLvl"]=true

			if globals.npcTriggered["advanceLvl"]:
				globals.npcRef["potato"].visible=false

		"home2":
			if globals.npcTriggered.has("beans") and globals.npcTriggered["beans"]==true and !globals.npcTriggered["advanceLvl"]:
				if globals.npcRef["beans"].visible:
					globals.getPlayer().changeMode("EatBeans")
				globals.npcRef["beans"].visible=false

				if globals.getPlayer().inAnimation==false:
					globals.npcTriggered["beans"]=false
					globals.npcTriggered["advanceLvl"]=true

			if globals.npcTriggered["advanceLvl"]:
				globals.npcRef["beans"].visible=false

		"home3":
			if globals.npcTriggered.has("knife") and globals.npcTriggered["knife"]==true and globals.npcRef["knife"].visible==true:
				globals.npcRef["knife"].visible=false
				globals.getPlayer().changeMode("Knife")
				makeDark()
				removeNodes()

func makeDark():
	self.modulate=Color("a2a2a2")

#before
func removeNodes():
	for node in nodesToRemove:
		node.get_parent().remove_child(node)

func removeAddNodes():
	for node in nodesToAdd:
		parentOfNodes.push_front(node.get_parent())
		globals.removeNode(node)

#after
func addNodes():
	for node in nodesToAdd:
		parentOfNodes[nodesToAdd.find(node)].add_child(node)
"""
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⠴⣒⠿⣿⠿⠋⠉⠙⡉⠉⠳⣖⠶⠶⣦⢄⡀⠀⠀⠀⠀⠀⠐⢦⣀⠀⠀⠈⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠚⢉⣠⠞⠡⠏⠁⠀⠀⠀⠀⠀⠀⠀⠈⠳⣄⠈⢷⡙⠻⣷⡶⢤⡀⠀⠀⠹⢣⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣤⠞⠉⢀⡴⠗⠁⠀⠄⠀⡄⢀⠀⠀⠀⠀⠀⠃⠀⠐⡌⠀⠀⢻⡀⠈⡉⠲⢍⡳⢆⠀⢀⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠛⠁⠀⢀⠞⠀⠀⠈⠄⠀⣼⠁⡾⠀⣠⠀⠀⢠⡇⠀⠀⢿⠀⠀⠀⣷⠀⠙⢦⡈⠱⣌⢳⣼⡆⠀⠀⡐⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠞⠋⠀⠀⢀⣴⠋⢀⣴⣥⡴⠧⠴⠷⠴⠷⠴⠿⢤⣄⣼⡇⢳⠀⢸⡄⠀⠀⠸⠀⠀⡀⠹⣄⠈⣧⣿⣷⣤⣞⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢤⣴⣾⣯⠞⠀⠀⣠⠞⣿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠀⠀⠙⢷⡈⡆⣼⣧⠀⡄⠀⡇⠀⣷⠠⣾⣿⣿⠁⠀⢸⢈⡿⣇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⡛⣢⣴⣿⣿⣿⠃⠀⢤⡀⢀⣄⠀⠀⠀⠛⠚⣿⣥⠀⠀⠀⠀⠀⠈⠻⠿⣽⠀⢹⠀⣷⢀⣿⡾⠛⠀⢻⡇⠀⢸⣞⢠⠏⢳⡄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠟⣹⢿⣿⣿⢀⣄⠀⣙⡛⠀⠀⠀⠀⠀⠻⣿⣽⣷⣦⣤⣿⣓⡀⠀⠀⢹⠀⠸⠀⣿⠀⠘⢳⣸⠀⠸⣇⠀⢀⡽⠃⡠⠞⢃⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠖⠓⢶⣯⡿⣽⣷⣼⣿⡿⢶⠦⠟⠀⠀⠀⠀⠛⠋⠹⠭⣭⡭⣽⢿⣿⠫⠁⢸⠀⢸⠀⣹⠀⣧⠈⠻⣇⠀⠻⣟⠉⠀⠀⠀⢰⢿⠀
⠀⠀⠀⠀⠀⠀⠀⣠⡾⠁⠀⠀⢠⡾⠁⢠⣧⣷⠟⠋⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣍⠛⠓⠀⠈⠀⢸⡀⡄⣧⡏⠳⢾⣷⣄⠈⠳⣄⣙⡦⠀⠀⠀⢀⡼⠀
⠀⠀⠀⠀⠀⠀⣨⠟⠁⠀⠀⣰⠟⠀⠀⣿⡟⠁⢀⣀⢠⠤⠄⠀⡟⠀⠲⠤⣄⠀⠀⠀⠀⠈⠳⣄⠀⠀⠀⣼⠀⠁⠙⣿⣶⣀⣈⣳⣴⠦⠭⠤⠖⣻⣿⠿⡿⠽⠂
⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⣰⠃⠀⠀⣾⣿⠀⠀⣾⢀⠤⣤⣦⣾⣿⣷⣾⠀⣿⣦⡀⠀⠀⠀⠀⠘⠀⠀⠀⡟⢠⠀⠈⡿⣿⣿⣿⣟⣿⢿⢻⡟⠛⢻⣌⠛⣧⡄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⢇⣴⠃⣸⠟⡏⠀⠀⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⢰⠃⠃⡄⢰⠛⠛⣾⣥⡌⢸⡿⠀⠘⢣⡄⡘⡆⠘⣿⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣼⣯⡞⡝⢠⡟⠀⣿⠀⠀⢹⣿⣿⣿⣿⠟⠉⠻⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⡟⣼⢀⢣⣼⠀⢀⣿⠟⠋⣼⠃⠀⠀⠀⢇⠙⣿⢦⣏⠀
⠀⠀⠀⠀⠀⠀⠀⣼⣏⡞⢰⡇⣸⠁⣸⣿⡄⠀⠀⣿⣿⣿⣿⣦⠀⠀⠈⠻⢿⣿⣿⣿⣿⠀⠀⠀⠀⣸⢡⠃⡾⢸⡟⣴⣯⠵⢀⣼⠃⠀⠄⠀⠀⢸⡄⡘⡆⢹⡆
⠀⠀⠀⠀⠀⠀⠰⣿⡿⢇⣸⡆⠇⢠⠿⣿⣿⠀⠀⢻⣿⣿⣿⢿⠀⣦⠀⠀⠘⣻⣿⣿⠟⠀⠀⠀⢠⢯⠇⣼⠁⢨⡟⣉⡥⠖⢻⡟⠀⠀⠀⠀⠀⠀⡇⡇⡇⠈⠇
⠀⠀⠀⠀⠀⠀⢀⣿⡇⠈⢻⠁⠀⡏⢷⣿⠋⢷⠀⢸⣿⡈⣿⠸⣄⠈⣦⢦⢠⣨⣿⡟⠀⠀⠀⠀⡞⠀⣰⡇⠸⣾⣞⡁⢀⡠⠞⢹⠀⢸⡀⠀⠀⢰⣿⢧⠃⠀⠀
⠀⠀⠀⠀⠀⠀⢸⣇⡇⠀⠘⡇⡰⠀⢸⠃⠀⡿⣇⠀⣘⡳⠾⠴⣿⠷⢛⠀⣻⠽⠋⠀⠀⠀⢀⡾⠃⣼⣿⠁⣰⣿⣿⠟⠋⠀⠀⠘⣿⣎⡇⠀⠀⣼⡯⠂⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⣿⠃⠀⡏⣿⠃⠀⡾⣀⠀⣇⠘⣄⠈⠉⠓⠲⠾⠒⠉⠉⢹⠀⠀⠀⠀⢰⡾⢁⢞⢿⡏⢠⢟⠟⡅⠀⠀⠀⠀⠀⠘⢮⣺⡀⠘⠉⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⡟⠀⢀⡷⠃⠀⡴⠃⠈⣦⠘⣆⠈⠷⣀⠤⠤⠤⢤⣶⣶⠛⠁⠀⠀⢀⡾⢁⣿⠋⣾⢠⠏⠈⣦⣤⡀⠀⠀⠀⠀⠀⠀⠀⠙⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣰⣾⠁⢀⡜⠀⢀⡜⠁⢀⡴⠉⢀⡟⠀⠀⣽⠀⠀⠀⠀⠙⣯⠀⠀⠀⣀⠞⣠⠟⠁⣰⣿⠋⠀⢀⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠈⠩⠻⣶⡏⠀⢀⣾⣀⡴⠋⠀⢀⠞⠀⢀⣀⣈⣤⣤⣤⣶⣶⣿⠀⠀⣰⠟⠋⠁⠀⣰⠏⣁⣤⣾⣿⣿⣿⣿⣳⣶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⡷⢤⡾⠋⠁⠀⣠⢴⣧⣴⡾⠋⣿⣿⣿⣿⣿⠟⠋⢹⠀⠀⠀⠀⠀⢀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣶⣦⣀⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⠁⠀⠱⣄⢰⠊⠀⣸⠟⠋⢀⣠⣿⣿⣿⣿⠋⠀⠀⠘⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣻⣍⣍⣥⣤⣤⣬⣱⣆⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⢸⣎⡴⠊⠁⢀⣴⣿⣿⣿⡿⠟⠁⠀⠀⢀⣀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣛⣭⣶⣾⡿⢛⣉⣉⣡⣤⣄⣈⣻⡄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⢀⡏⠙⣄⢠⠶⣿⣿⣿⣿⣯⣤⣤⣤⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣋⣤⣿⡿⢛⣩⣴⣾⡿⠿⠛⠛⠋⠉⠁⢀⣱⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⢸⠁⠀⣸⠛⢛⡟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢋⣡⣴⣾⢟⣯⡵⠾⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢰⠇⠀⠀⢸⠀⢀⡏⠀⣿⣿⣷⣍⣩⠵⢿⣿⣿⠿⠿⠿⠛⣛⢉⣠⣤⣿⣾⢿⣻⣽⡾⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇⠀⠀⠀
⢠⡄⠀⠀⠀⢀⡞⠀⠀⠀⢸⡄⣸⠁⢦⡹⣷⣿⣿⣷⣶⣿⣿⣶⣶⣶⣶⣿⡿⠿⣛⣯⣵⡾⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠁⠀⠀⠀⠀⢣⠀⠀⠀
⠀⠹⣾⡄⠀⢸⠁⠀⠀⠀⡜⢡⡇⢠⣾⠀⠙⢿⣟⠿⢶⣤⣽⣭⣭⣴⣶⣿⣿⠿⠛⠏⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀
⠀⠀⠈⢷⡀⢸⠀⠀⠀⢰⣧⣟⣠⠟⠸⣷⡀⠀⠀⢻⣤⣀⡀⠉⠉⠉⢀⣤⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠙⠺⠒⠂⠒⠛⠛⠉⠁⠀⢀⡇⠙⣦⠴⠛⢿⠀⠉⠙⠛⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠀⠄⡏⠀⠀⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡏⠀⠀⠀⠃⠀⣠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣧⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡄⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⣰⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"""
