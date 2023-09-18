extends Node2D

@export var knife:Sprite2D
@export var nodesToRemove:Array[Node2D]
@export var nodesToAdd:Array[Node2D]
var parentOfNodes:Array[Node2D]
var nearLadder:bool=false

# Called when the node enters the scene tree for the first time.
func _ready():
	if globals.knifeTaken:
		knife.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match self.name:
		"home1":
			if globals.knifeTaken==true:
				knife.visible=false

			if Input.is_action_just_pressed("ui_accept") and nearLadder:
				get_tree().change_scene_to_file("scenes/attic1.tscn")
		"home2":
			if globals.knifeTaken==true:
				knife.visible=false

			if Input.is_action_just_pressed("ui_accept") and nearLadder:
				get_tree().change_scene_to_file("scenes/attic2.tscn")
		"home3":
			if globals.knifeTaken==true:
				knife.visible=false
				globals.getPlayer().changeMode("Knife")
				makeDark()
				removeNodes()
				globals.knifeTaken=false

			if Input.is_action_just_pressed("ui_accept") and nearLadder:
				get_tree().change_scene_to_file("scenes/attic3.tscn")

func _on_ladder_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=false

func _on_ladder_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=true

func makeDark():
	self.modulate=Color("a2a2a2")

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
