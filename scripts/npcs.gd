extends StaticBody2D

var parent:Sprite2D
var npcName:String
var npcConv:int=0
var npcConv2:int=0
var nearNpc:bool=false
var inConversation:bool=false
var stringArray2:Array[String]
# Called when the node enters the scene tree for the first time.
func _ready():
	parent=get_parent()
	npcName=self.name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if nearNpc and ((text_box.current_state==text_box.State.ready and Input.is_action_just_pressed("ui_accept")) or inConversation):
		inConversation=true
		match globals.getCurrentScene().name:
			"attic1":
				match npcName:
					"salami":
						match npcConv:
							0:
								text_box.queue_text("hi, i'm your brother, Salami-red
								do you need anything?")
								text_box.queue_questionResponse("where are we?")
								text_box.queue_text("we are in the attic of the house obviously
								(he is looking down on you)")
								text_box.queue_questionResponse("well, what are we doing here?")
								text_box.queue_text("talking
								(omg you are so inferiour to him)")
								text_box.queue_questionResponse("not that, i mean, in general")
								text_box.queue_text("you know...eating, sleeping, breathing
								(you got outplayed. you should change your strategy)")
								npcConv+=1
							1:
								conversation(["stop avoiding questions, it's annoying",

								"good mornin sir, i'm Gabriel, and i wish to inform you that I'm hungry and therefore, i would enjoy to ask you, kind sir, if you happened to hold any food currently. i would like to also ask you the privilege of knowing where am i currently located and what's the year in which we are currently living",

								"i don't know what you are referring to
								i answered to all your questions correspondingly
								(you have been demolished)
								(he's clearly much more intellectual than you)",

								"yes, indeed, good sir, i'm sorry to inform you but i currently dont have any food and i believe there is no edible food around here. tho i'm delighted to inform you that we are located in France in the year 1779
								have a good day sir"])

					"bed":
						match npcConv:
							0:
								text_box.queue_text("bed")
								text_box.queue_questionResponse("go to bed
									sleep
									sleep later")
								npcConv+=1
							1:
								if text_box.current_state==text_box.State.ready:
									match text_box.IndexChosen:
										0:
											globals.levelStart=true
											get_tree().change_scene_to_file("scenes/attic2.tscn")
											globals.knifeTaken=false
										1:
											globals.levelStart=true
											get_tree().change_scene_to_file("scenes/attic2.tscn")
											globals.knifeTaken=false
										2:
											npcConv=0
									inConversation=false
			"attic2":
				match npcName:
					"salami":
						match npcConv:
							0:
								text_box.queue_text("hei gabriel
								time flies doesn't it?
								i should inform you that you smell really really really bad
								(he just made fun of you playing League of Legends)")
								npcConv+=1
							1:
								conversation(["what happened in the timeskip?",

								"(give Salami some crisps and biscuits)",

								"Miduel died
								he was caught in a field fire and burned to death
								crazy story isn't it?",

								"(he is so happy to see those biscuits and crisps)
								(he ate all the biscuits and crisps)"])
					"bed":
						match npcConv:
							0:
								text_box.queue_text("bed")
								text_box.queue_questionResponse("go to bed
									sleep
									sleep later")
								npcConv+=1
							1:
								if text_box.current_state==text_box.State.ready:
									match text_box.IndexChosen:
										0:
											globals.levelStart=true
											get_tree().change_scene_to_file("scenes/attic3.tscn")
										1:
											globals.levelStart=true
											get_tree().change_scene_to_file("scenes/attic3.tscn")
										2:
											npcConv=0
									inConversation=false
			"attic3":
				match npcName:
					"salami":
						match npcConv:
							0:
								text_box.queue_text("hei gabriel
								time flies doesn't it?
								i should inform you that you smell really really really bad
								(he told you that you smell and that you should take a shower)")
								text_box.queue_text("where is Miguel
								(give Salami some crisps and biscuits)")
								npcConv+=1
			"home1":
				match npcName:
					"bucket":
						match npcConv:
							0:
								text_box.queue_text("buckets")
								inConversation=false
					"miguel":
						match npcConv:
							0:
								text_box.queue_text("hi, i'm Miguel, i like fire
								if you want we could go and set fire to some cats and let them run into the field
								then we could watch the field burn
								that would be fun")
								inConversation=false
					"knife":
						match npcConv:
							0:
								if globals.knifeTaken==false:
									text_box.queue_text("an old knife lays before you")
									text_box.queue_questionResponse("take the knife :)
									don't take the knife
									take the knife later")
									npcConv+=1
							1:
								if text_box.current_state==text_box.State.ready:
									match text_box.IndexChosen:
										0:
											text_box.queue_text("you took the knife")
											parent.visible=false
											globals.knifeTaken=true
											globals.getPlayer().animationChange("Knife")
											npcConv+=1
										1:
											text_box.queue_text("you accidentally took the knife")
											parent.visible=false
											globals.knifeTaken=true
											globals.getPlayer().animationChange("Knife")
											npcConv+=1
										2:
											npcConv=0
									inConversation=false
					"veranda":
						match npcConv:
							0:
								text_box.queue_text(":)
								I am your mother, Veranda
								but you WILL call me \"mommy\" ")
								npcConv+=1
							1:
								conversation(["where is dad, mommy?",

							"hi mommy, give me food please",
							
							"he'll be here soon
							he just went for some milk",
							
							"you hungry?
							skill issue
							just dont be hungry anymore wtf",])
								
			"home2":
				match npcName:
					"bucket":
						match npcConv:
							0:
								text_box.queue_text("more buckets")
								inConversation=false
					"knife":
						match npcConv:
							0:
								if globals.knifeTaken==false:
									text_box.queue_text("an old knife lays before you")
									text_box.queue_questionResponse("take the knife :)
									don't take the knife
									take the knife later")
									npcConv+=1
							1:
								if text_box.current_state==text_box.State.ready:
									match text_box.IndexChosen:
										0:
											text_box.queue_text("you took the knife")
											parent.visible=false
											globals.knifeTaken=true
											globals.getPlayer().animationChange("Knife")
											npcConv+=1
										1:
											text_box.queue_text("you accidentally took the knife")
											parent.visible=false
											globals.knifeTaken=true
											globals.getPlayer().animationChange("Knife")
											npcConv+=1
										2:
											npcConv=0
									inConversation=false
			"home3":
				match npcName:
					"bucket":
						match npcConv:
							0:
								text_box.queue_text("even more buckets")
								inConversation=false
					"knife":
						match npcConv:
							0:
								if globals.knifeTaken==false:
									text_box.queue_text("an old knife lays before you")
									text_box.queue_questionResponse("take the knife :)
									don't take the knife
									take the knife later")
									npcConv+=1
							1:
								if text_box.current_state==text_box.State.ready:
									match text_box.IndexChosen:
										0:
											text_box.queue_text("you took the knife")
											parent.visible=false
											globals.knifeTaken=true
											globals.getPlayer().animationChange("Knife")
											npcConv+=1
										1:
											text_box.queue_text("you accidentally took the knife")
											parent.visible=false
											globals.knifeTaken=true
											globals.getPlayer().animationChange("Knife")
											npcConv+=1
										2:
											npcConv=0
									inConversation=false


										
func conversation(stringArray:Array[String]):
	match npcConv2:
		0:
			stringArray2=stringArray.duplicate()
			npcConv2+=1
		1:
			if stringArray2.size()==0:
				return 0
			var questions:String
			for i in stringArray2.size()/2:
				questions+= stringArray2[i]
				if i<stringArray2.size()/2-1:
					questions+="\n"
			print(questions)
			text_box.queue_questionResponse(questions)
			npcConv2+=1
		2:
			if text_box.current_state==text_box.State.ready:
				text_box.queue_text(stringArray2[text_box.IndexChosen+stringArray2.size()/2])
				npcConv2-=1
				inConversation=false
				stringArray2.remove_at(text_box.IndexChosen+stringArray2.size()/2)
				stringArray2.remove_at(text_box.IndexChosen)


func _on_area_2d_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearNpc=true
func _on_area_2d_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearNpc=false
