extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.npcTriggered.has("mundo") and globals.npcTriggered["mundo"]:
		globals.npcRef["mundo"].get_child(1).play("normal")
		globals.getPlayer().changeMode("EatBucket")
		globals.npcTriggered["mundo"]=false

	if globals.npcTriggered.has("iulica") and globals.npcTriggered["iulica"]:
		globals.npcRef["iulica"].get_child(1).play("noLeg")
		globals.getPlayer().changeMode("EatLeg")
		globals.npcTriggered["iulica"]=false

	if globals.npcTriggered.has("yuumi") and globals.npcTriggered["yuumi"]:
		globals.npcRef["yuumi"].get_child(1).play("noLimbs")
		globals.npcRef["adc"].get_child(1).play("scared")
		globals.getPlayer().changeMode("EatLimbs")
		globals.npcTriggered["yuumi"]=false
	