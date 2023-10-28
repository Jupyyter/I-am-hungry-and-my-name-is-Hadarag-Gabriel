extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if globals.npcTriggered.has("mundo") and globals.npcRef["mundo"]!=null and globals.npcTriggered["mundo"] and !globals.npcRef["mundo"].get_child(1).current_animation=="normal":
		globals.npcRef["mundo"].get_child(1).play("normal")

	if globals.npcTriggered.has("iulica") and globals.npcRef["iulica"]!=null and globals.npcTriggered["iulica"]and !globals.npcRef["iulica"].get_child(1).current_animation=="noLeg":
		globals.npcRef["iulica"].get_child(1).play("noLeg")
		
	if globals.npcTriggered.has("yuumi") and globals.npcRef["yuumi"]!=null and globals.npcTriggered["yuumi"] and !globals.npcRef["yuumi"].get_child(1).current_animation=="noLimbs":
		globals.npcRef["yuumi"].get_child(1).play("noLimbs")
		globals.npcRef["adc"].get_child(1).play("scared")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.npcTriggered.has("mundo") and globals.npcTriggered["mundo"] and globals.npcRef["mundo"]!=null and !globals.npcRef["mundo"].get_child(1).current_animation=="normal":
		globals.getPlayer().changeMode("EatBucket")
		globals.npcRef["mundo"].get_child(1).play("normal")

	if globals.npcTriggered.has("iulica") and globals.npcTriggered["iulica"] and globals.npcRef["iulica"]!=null and !globals.npcRef["iulica"].get_child(1).current_animation=="noLeg":
		globals.getPlayer().changeMode("EatLeg")
		globals.npcRef["iulica"].get_child(1).play("noLeg")

	if globals.npcTriggered.has("yuumi") and globals.npcTriggered["yuumi"] and globals.npcRef["yuumi"]!=null and !globals.npcRef["yuumi"].get_child(1).current_animation=="noLimbs":
		print(globals.npcRef["yuumi"].get_child(1).current_animation)
		globals.getPlayer().changeMode("EatLimbs")
		globals.npcRef["yuumi"].get_child(1).play("noLimbs")
		globals.npcRef["adc"].get_child(1).play("scared")
	
