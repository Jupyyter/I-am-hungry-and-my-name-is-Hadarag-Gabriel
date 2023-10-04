extends Node

var playerAnimation:String=""
var levelStart:bool=true
var knifeTaken:bool=false
var flapjackCry:bool=false
var nearFlapjack2:bool=false
#used to remember where the text was left of on every npc
var convState:Dictionary
#use this to activate complex behaviour on other script instead of mixing test and actual code
var npcTriggered:Dictionary
var npcRef:Dictionary


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

#false = remove_child true = queue_free
func removeNode(node:Node,delete:bool=false):
	if !delete:
		node.get_parent().remove_child(node)
	else:
		node.queue_free()
