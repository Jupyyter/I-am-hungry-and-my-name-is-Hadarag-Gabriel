extends StaticBody2D

var npcName:String
var npcConv:int=0
var npcConv2:int=0
var nearNpc:bool=false
var inConversation:bool=false
var stringArray2:Array[String]#used in "conversation" function

# called when the node enters the scene tree for the first time
func _ready():
	npcName=self.name
	if !globals.convState.has(npcName):
		globals.convState[npcName]=npcConv

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if nearNpc and ((text_box.current_state==text_box.State.ready and Input.is_action_just_pressed("ui_accept")) or inConversation):
		npcConv=globals.convState[npcName]
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
								have a good day sir"],
								1)

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
					"sussy":
						match npcConv:
							0:

								text_box.queue_text("(keep in mind \"it's ok to like muscular men\"- gabriel)
								(you should make her avoid you)
								hi im Sussy")
								text_box.queue_questionResponse("i play league of legends")
								text_box.queue_text("that explains the smell
								take a shower
								and dont come near me")
								npcConv+=1
					"noodle":
						match npcConv:
							0:
								text_box.queue_text("im Noodle Doodle-Doo")
								text_box.queue_questionResponse("you look like you got run over by a car")
								text_box.queue_text("no this is how i was born")
								text_box.queue_questionResponse("oh so you were born run over by a car?")
								text_box.queue_text("yes")
								npcConv+=1
							
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

								"who are those people?",

								"Miduel died
								he was caught in a field fire and burned to death
								crazy story isn't it?",

								"(he is so happy to see those biscuits and crisps)
								(he ate all the biscuits and crisps)",
							
								"those are your siblings
								also
								see that one in the corner?
								he's Schnitzel
								go to him and say the word \"crazy\" "])
					"snitel":
						match npcConv:
							0:
								text_box.queue_text("go away")
								text_box.queue_questionResponse("crazy
								crazy bastard")
								npcConv+=1
							1:
								if text_box.current_state==text_box.State.ready:
									match text_box.IndexChosen:
										0:
											text_box.queue_text("Crazy?
											I was crazy once.
											They locked me in a room.
											A rubber room.
											A rubber room with rats.
											And rats make me crazy.")
										1:
											text_box.queue_text("CRAZY?
											I WAS CRAZY ONCE.
											THEY LOCKED ME IN A ROOM.
											A RUBBER ROOM.
											A RUBBER ROOM WITH RATS.
											AND RATS MAKE ME CRAZY.")
									inConversation=false
											
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
								(he basically made fun of you playing League of Legends)")
								text_box.queue_questionResponse("where is Miguel
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
								text_box.queue_text("hi, i'm Miguel
								i like fire
								later i plan going to set fire to some cats and let them run into the field
								then i could watch the field burn
								that would be fun
								if you want you can come with me")
								inConversation=false
								npcConv+=1
					"potato":
						match npcConv:
							0:
								if globals.knifeTaken==false:
									text_box.queue_text("potato")
									text_box.queue_questionResponse("eat the poato :)
									don't eat the potato
									eat the poato later")
									npcConv+=1
							1:
								if text_box.current_state==text_box.State.ready:
									match text_box.IndexChosen:
										0:
											text_box.queue_text("you ate the raw potato
											it was full of dirt, but gabriel ate it anyway
											but gabriel is still hungry
											but there is no more food
											(imagine beeng poor)
											it might be amimir time (amimir = speel)")
											globals.knifeTaken=true
											npcConv+=1
										1:
											text_box.queue_text("you accidentally ate the raw potato
											it was full of dirt, but gabriel ate it anyway
											but gabriel is still hungry
											but there is no more food
											(imagine beeng poor)
											it might be amimir time (amimir = speel)")
											globals.knifeTaken=true
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
					"fiddlesticks":
						match npcConv:
							0:
								text_box.queue_text("(don't forget gabriel doesn't like women)
								hello, im Fiddlesticks")
								text_box.queue_questionResponse("hi i use Arch Linux")
								text_box.queue_text("i see
								i bet you even play League of Legends
								get away from me
								(mission accomplished)")
								npcConv+=1
					"bucket":
						match npcConv:
							0:
								text_box.queue_text("more buckets")
								inConversation=false
					"beans":
						match npcConv:
							0:
								if globals.knifeTaken==false:
									text_box.queue_text("random beans")
									text_box.queue_questionResponse("eat beans
									don't eat beans
									eat the beans later")
									npcConv+=1
							1:
								if text_box.current_state==text_box.State.ready:
									match text_box.IndexChosen:
										0:
											text_box.queue_text("you ate the raw beans
											did you know that raw beans are toxic?
											...
											amimir time")
											globals.knifeTaken=true
											npcConv+=1
										1:
											text_box.queue_text("you accidentally ate the raw beans
											did you know that raw beans are toxic?
											...
											amimir time")
											globals.knifeTaken=true
											npcConv+=1
										2:
											npcConv=0
									inConversation=false
			"home3":
				match npcName:
					"veranda":
						match npcConv:
							0:
								text_box.queue_text("did you know cannibalism is not illegal?")
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
											globals.knifeTaken=true
											npcConv+=1
										1:
											text_box.queue_text("you accidentally took the knife")
											globals.knifeTaken=true
											npcConv+=1
										2:
											npcConv=0
									inConversation=false

		globals.convState[npcName]=npcConv


#give this function 5 statements and 5 responses (must be equal otherwise error) and after every response, kill the precedent statement							
func conversation(stringArray:Array[String],correctAnswer:int=-1):
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
			text_box.queue_questionResponse(questions)
			npcConv2+=1
		2:
			if text_box.current_state==text_box.State.ready:
				text_box.queue_text(stringArray2[text_box.IndexChosen+stringArray2.size()/2])
				npcConv2-=1
				inConversation=false
				stringArray2.remove_at(text_box.IndexChosen+stringArray2.size()/2)
				stringArray2.remove_at(text_box.IndexChosen)
				if stringArray2.is_empty() or (correctAnswer!=-1 and text_box.IndexChosen==correctAnswer):#if you chose the right answer and choice==true then npcConv+=1
					npcConv+=1


func _on_area_2d_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearNpc=true


func _on_area_2d_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearNpc=false

#:):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):)
