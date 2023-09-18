extends Node2D

@export var nodesToRemove:Array[Node2D]
@export var nodesToAdd:Array[Node2D]
var parentOfNodes:Array[Node2D]
@export var rat:Node2D
@export var cat:Node2D
@export var flapjack2:Node2D
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
	match self.name:
		"attic1":
			if(Input.is_action_just_pressed("ui_accept")) :
				if nearLadder:
					get_tree().change_scene_to_file("scenes/home1.tscn")
			if globals.nearRat==true and text_box.current_state==text_box.State.ready:
				globals.getPlayer().changeMode("EatRat")
				globals.removeNode(rat)
				globals.nearRat=false
				globals.getPlayer().inAnimation=true
		"attic2":
			if(Input.is_action_just_pressed("ui_accept")) :
				if nearLadder:
					get_tree().change_scene_to_file("scenes/home2.tscn")
			if globals.nearRat==true and rat!=null and text_box.current_state==text_box.State.ready:
				globals.getPlayer().changeMode("EatRat")
				globals.removeNode(rat,true)
				globals.getPlayer().inAnimation=true
			if globals.nearCat==true and text_box.current_state==text_box.State.ready:
				globals.getPlayer().changeMode("EatCat")
				globals.removeNode(cat)
				globals.nearCat=false
				globals.getPlayer().inAnimation=true
		"attic3":
			if(Input.is_action_just_pressed("ui_accept")) :
				if nearLadder:
					get_tree().change_scene_to_file("scenes/home3.tscn")
			if globals.nearFlapjack2==true and text_box.current_state==text_box.State.ready:
				globals.getPlayer().changeMode("EatFlapjack")
				globals.removeNode(flapjack2)
				#globals.nearFlapjack2=false
				globals.getPlayer().inAnimation=true


func _on_ladder_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=true


func _on_ladder_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=false


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
		parentOfNodes[nodesToAdd.find(node)].add_child(node)
