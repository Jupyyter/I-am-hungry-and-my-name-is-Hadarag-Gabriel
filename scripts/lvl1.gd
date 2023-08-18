extends Node2D

var nearLadder:bool=false
var nearSalami:bool=false
var salamiConv:int=0
var miguelConv:int=0
var nearMiguel:bool=false

#text_box is autoloaded since im using it in every lvl
@onready var textBox :textBoxClass = get_node("/root/text_box")

func _ready():
	pass

func _process(delta):
	if(nearLadder):
		if(Input.is_action_just_pressed("ui_accept")):
			get_tree().change_scene_to_file("scenes/lvl2.tscn")

	if(nearSalami):
		if (textBox.current_state==text_box.State.ready and Input.is_action_just_pressed("ui_accept")) or player.inConversation:
			player.inConversation=true
			match salamiConv:
				0:
					text_box.queue_text("hi, i'm your brother, Salami-red
					do you need anything?")
					salamiConv+=1
				1:
					text_box.queue_questionResponse("I'm hungry
					Hi, Im Gabriel, and i wish to inform you that I'm hungry")
					salamiConv+=1
				2:
					if textBox.current_state==text_box.State.ready:
						if text_box.IndexChosen==0:
							text_box.queue_text("Yea, I'm hungry too")
							player.inConversation=false
						elif text_box.IndexChosen==1:
							text_box.queue_text("skill issue")
							player.inConversation=false
						salamiConv+=1
				3:
					text_box.queue_text("saddsadsadsadsa
					sadadsdsa")
					salamiConv+=1

	if(nearMiguel):
		if(Input.is_action_just_pressed("ui_accept") and textBox.current_state==text_box.State.ready):
			match miguelConv:
				0:
					text_box.queue_text("hi, i'm your brother, Miguel
					aaaaaaaaaaaaaaaaaaa")
					miguelConv+=1
				1:
					text_box.queue_text("...")


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



func _on_salami_2_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearSalami=false

func _on_salami_2_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearSalami=true



func _on_miguel_2_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearMiguel=false

func _on_miguel_2_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearMiguel=true
