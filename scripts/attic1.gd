extends Node2D

@export var nodesToRemove:Array[Node2D]
@export var nodesToAdd:Array[Node2D]
var parentOfNodes:Array[Node2D]
var nearLadder:bool=false

#text_box is autoloaded since im using it in every lvl
@onready var textBox :textBoxClass = get_node("/root/text_box")

func _ready():
	removeAddNodes()
	if globals.knifeTaken:
		removeNodes()
		addNodes()
	#after sleeping, reset character sprite and position
	if globals.levelStart:
		match self.name:
			"attic1":
				globals.getPlayer().position=Vector2(161,234)
			"attic2":
				globals.getPlayer().position=Vector2(161,234)
			"attic3":
				globals.getPlayer().position=Vector2(1110,366)
		globals.knifeTaken=false
		globals.levelStart=false
		globals.getPlayer().animationReset()

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		if(nearLadder):
			match self.name:
				"attic1":
					get_tree().change_scene_to_file("scenes/home1.tscn")
				"attic2":
					get_tree().change_scene_to_file("scenes/home2.tscn")
				"attic3":
					get_tree().change_scene_to_file("scenes/home3.tscn")


func _on_ladder_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=true


func _on_ladder_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=false

#before
func removeNodes():
	for node in nodesToRemove:
		node.get_parent().remove_child(node)

func removeAddNodes():
	for node in nodesToAdd:
		parentOfNodes.push_front(node.get_parent())
		node.get_parent().remove_child(node)

#after
func addNodes():
	for node in nodesToAdd:
		parentOfNodes[nodesToAdd.find(node)].add_child(node)
