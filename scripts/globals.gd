extends Node

var playerAnimation:String=""
var levelStart:bool=true
var knifeTaken:bool=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getPlayer()->player:
	#be sure to add a group named "player" on player :)
	return get_tree().get_nodes_in_group("player")[0]

func getCurrentScene()->Node:
	return get_tree().current_scene