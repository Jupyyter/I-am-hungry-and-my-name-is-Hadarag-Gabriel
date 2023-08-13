extends Node2D

var nearLadder:bool=false
var lastPosition:Vector2=Vector2.ZERO

#text_box is autoloaded since im using it in every lvl
@onready var textBox :textBoxClass = get_node("/root/text_box")

func _ready():
	pass

func _process(delta):
	if(nearLadder):
		if(Input.is_action_just_pressed("ui_accept")):
			get_tree().change_scene_to_file("scenes/lvl2.tscn")
	#called when the textBox has just finished showing an entire conversation
	if(text_box.endOfConversation):
		#get_tree().change_scene_to_file("scenes/lvl2.tscn")
		text_box.endOfConversation=false

func _on_ladder_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=true


func _on_ladder_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=false
