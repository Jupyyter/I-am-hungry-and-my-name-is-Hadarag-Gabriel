extends Node2D

@export var knife:Sprite2D
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
				globals.getPlayer().animationChange("Knife")
				makeDark()

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