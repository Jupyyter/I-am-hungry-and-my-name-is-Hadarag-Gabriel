extends Node2D

func _ready():
	if globals.npcTriggered.has("door1") and globals.npcTriggered["door1"]:
		globals.getPlayer().position=Vector2(-296,36)
		globals.npcTriggered["door1"]=false

	if globals.npcTriggered.has("door2") and globals.npcTriggered["door2"]:
		globals.getPlayer().position=Vector2(-113,36)
		globals.npcTriggered["door2"]=false

	if globals.npcTriggered.has("door3") and globals.npcTriggered["door3"]:
		globals.getPlayer().position=Vector2(70,36)
		globals.npcTriggered["door3"]=false

	if globals.npcTriggered.has("door4") and globals.npcTriggered["door4"]:
		globals.npcTriggered["door4"]=false
		globals.getPlayer().position=Vector2(244,36)

func _process(delta):
	if globals.npcTriggered.has("door1") and globals.npcTriggered["door1"]:
		get_tree().change_scene_to_file("scenes/hospitalRoom1.tscn")

	if globals.npcTriggered.has("door2") and globals.npcTriggered["door2"]:
		get_tree().change_scene_to_file("scenes/bloodRoom.tscn")

	if globals.npcTriggered.has("door3") and globals.npcTriggered["door3"]:
		get_tree().change_scene_to_file("scenes/bloodRoom2.tscn")

	if globals.npcTriggered.has("door4") and globals.npcTriggered["door4"]:
		get_tree().change_scene_to_file("scenes/hospitalRoom1.tscn")
