extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.npcTriggered["cockroach"]:
		globals.getPlayer().changeMode("EatCockroach")
		globals.npcTriggered["cockroach"]=false
		globals.npcRef["cockroach"].visible=false

	if globals.npcTriggered["garbage"]:
		globals.getPlayer().changeMode("EatGarbage")
		globals.npcTriggered["garbage"]=false
		globals.npcRef["garbage"].visible=false

	if globals.npcTriggered["wall"]:
		globals.getPlayer().changeMode("EatWall")
		globals.npcTriggered["wall"]=false
		globals.npcRef["wall"].visible=false

	if globals.npcTriggered["stopSign"]:
		globals.getPlayer().changeMode("EatStopSign")
		globals.npcTriggered["stopSign"]=false
		globals.npcRef["stopSign"].visible=false
