extends Node2D

var nearLadder:bool=false

#text_box is autoloaded since im using it in every lvl
@onready var textBox :textBoxClass = get_node("/root/text_box")

func _ready():
	#after sleeping, reset character sprite and position
	if globals.levelStart:
		match self.name:
			"attic1":
				globals.getPlayer().position=Vector2(161,234)
			"attic2":
				globals.getPlayer().position=Vector2(161,234)
			"attic3":
				globals.getPlayer().position=Vector2(1110,366)
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
