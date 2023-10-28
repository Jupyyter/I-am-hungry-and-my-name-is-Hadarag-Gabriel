extends Node2D

@export var nodesToRemove:Array[Node2D]
@export var nodesToAdd:Array[Node2D]
var parentOfNodes:Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	if globals.npcTriggered.has("potato") and globals.npcRef["potato"]!=null and globals.npcTriggered["potato"]==true:
		globals.npcRef["potato"].visible=false
	elif globals.npcTriggered.has("beans") and globals.npcRef["beans"]!=null and globals.npcTriggered["beans"]==true:
		globals.npcRef["beans"].visible=false



# Called every frame. 'delta' is the elapsed time since the previous  frame.
func _process(delta):
	match self.name:
		"home1":
			if globals.npcTriggered.has("potato") and globals.npcTriggered["potato"]==true:
				if globals.npcRef["potato"].visible:
					globals.getPlayer().changeMode("EatPotato")
				globals.npcRef["potato"].visible=false

		"home2":
			if globals.npcTriggered.has("beans") and globals.npcTriggered["beans"]==true:
				if globals.npcRef["beans"].visible:
					globals.getPlayer().changeMode("EatBeans")
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
