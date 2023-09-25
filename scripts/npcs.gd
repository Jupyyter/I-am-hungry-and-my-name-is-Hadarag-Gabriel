extends StaticBody2D

var npcName:String
var npcConv:int=0
var npcConv2:int=0
var nearNpc:bool=false
var inChat:bool=false
var stringArray2:Array[String]#used in "conversation" function
var currentScene:String
var parent #usually Sprite2D
@export var flipCharacter:bool=true

# called when the node enters the scene tree for the first time
func _ready():
	currentScene=globals.getCurrentScene().name
	npcName=self.name
	parent=self.get_parent()
	if !globals.convState.has(npcName+currentScene):
		globals.convState[npcName+currentScene]=npcConv

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if nearNpc and ((textReady() and Input.is_action_just_pressed("ui_accept")) or inChat):
		npcConv=globals.convState[npcName+currentScene]
		inChat=true
		#guess what does this code do
		if flipCharacter:
			if globals.getPlayer().global_position.x>self.global_position.x:
				parent.flip_h=false
			else:
				parent.flip_h=true
		match currentScene:
			"attic1":
				match npcName:
					"salami":
						match npcConv:
							0:
								text_box.queue_text("hi, i'm your brother, Salami--red
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

								"good mornin sir, i'm Gabriel, and i wish to inform you that I'm hungry and therefore, i would enjoy to ask you, kind sir, if you happened to keep ahold of any food currently. i would like to also ask you the privilege of knowing where am i currently located and what's the year in which we are currently living",

								"i don't know what you are referring to
								i answered to all your questions correspondingly
								(you have been demolished)
								(he's clearly much more intellectual than you)",

								"yes, indeed, good sir, i'm sorry to inform you but i currently dont have any food and i believe there is no edible food around here. tho i'm delighted to inform you that we are located in France in the year 1779
								have a good day sir"],
								[1])
							2:
								endOfChat()
					"rat":
						match npcConv:
							0:
								text_box.queue_questionResponse("pet the dead rat")
								npcConv+=1
							1:
								if textReady():
									text_box.queue_text("gabriel reaches for the rat")
									globals.nearRat=true
									endOfChat(npcConv+1)


					"bed":
						if globals.nearRat:
							match npcConv:
								0:
									text_box.queue_text("bed")
									text_box.queue_questionResponse("go to bed
										sleep
										sleep later")
									npcConv+=1
								1:
									if textReady():
										match text_box.IndexChosen:
											0:
												globals.levelStart=true
												get_tree().change_scene_to_file("scenes/attic2.tscn")
												globals.knifeTaken=false
												endOfChat(npcConv+1)
											1:
												globals.levelStart=true
												get_tree().change_scene_to_file("scenes/attic2.tscn")
												globals.knifeTaken=false
												endOfChat(npcConv+1)
											2:
												endOfChat(0)
						else:
							text_box.queue_text("but gabriel is still hungry")
							inChat=false
			"attic2":
				match npcName:
					"cat":
						if globals.nearRat:
							match npcConv:
								0:
									text_box.queue_text("this is Garfield
									pet Garfield?")
									text_box.queue_questionResponse("i dont pet dead cats
									pet Garfield")
									npcConv+=1
								1:
									if textReady():
										match text_box.IndexChosen:
											0:
												text_box.queue_text("too bad")
											1:
												text_box.queue_text(":)")
										globals.nearCat=true
										endOfChat(npcConv+1)
						else:
							text_box.queue_text("gabriel is too hungry to look at the dead cat")
							endOfChat(0)
					"rat":
						match npcConv:
							0:
								text_box.queue_text("pet the dead rat?")
								text_box.queue_questionResponse("yeah
								noh")
								npcConv+=1
							1:
								if textReady():
									match text_box.IndexChosen:
										0:
											npcConv+=2
										1:
											text_box.queue_text("you sure?")
											text_box.queue_questionResponse("yeah
											noh")
											npcConv+=1
							2:
								if textReady():
									match text_box.IndexChosen:
										0:
											npcConv+=1
											text_box.queue_text("(i don't believe you)")
										1:
											npcConv+=1
							3:
								if textReady():
									text_box.queue_text("gabriel approaches the rat to pet it")
									globals.nearRat=true
									endOfChat(npcConv+1)
					"sussy":
						match npcConv:
							0:

								text_box.queue_text("(keep in mind \"it's ok to like muscular men\"- gabriel)
								(its in gabriel's interest to avoid women)
								hi im Sussy")
								text_box.queue_questionResponse("i play league of legends")
								text_box.queue_text("that explains the smell
								take a shower
								and dont come near me")
								endOfChat(npcConv+1)
					"noodle":
						match npcConv:
							0:
								text_box.queue_text("im Noodle Doodle-Doo")
								text_box.queue_questionResponse("you look like you got run over by a car")
								text_box.queue_text("no, this is how i was born")
								text_box.queue_questionResponse("oh so you were born run over by a car?")
								text_box.queue_text("yes got a probblem with people born run over by cars?")
								npcConv+=1
							1:
								if textReady():
									conversation(["no, i personally was born run over by a traktor",

									"yes, i im very racist. i hate everyone run over by anything but men. in fact i have every person with a slightly darker RGBA skin color than mine",

									"fair enough",

									"ah is that so?
									i wish you a night full of warm pillows"],[0,1])
							2:
								endOfChat()
							
					"salami":
						match npcConv:
							0:
								text_box.queue_text("hei gabriel
								time flies doesn't it?
								i should inform you that you smell really really really bad
								(take a shower maybe?)")
								npcConv+=1
							1:
								conversation(["what happened in the timeskip?",

								"(give Salami some crisps and biscuits)",

								"what are these strangers doing in my house?",

								"Miguel died
								his last words where \"i need more bullets, please sir give me more bullets\"",

								"(he is so happy to see those biscuits and crisps)
								(he ate all the biscuits and crisps)",
							
								"those are your siblings
								also
								see that one in the corner?
								he's Schnitzel
								go to him and say the word \"crazy\" "])
							2:
								endOfChat()
					"snitel":
						match npcConv:
							0:
								text_box.queue_text("go away")
								text_box.queue_questionResponse("crazy
								crazy bastard")
								npcConv+=1
							1:
								if textReady():
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
									endOfChat()
											
					"bed":
						if globals.nearCat:
							match npcConv:
								0:
									text_box.queue_text("bed")
									text_box.queue_questionResponse("go to bed
										sleep
										sleep later")
									npcConv+=1
								1:
									if textReady():
										match text_box.IndexChosen:
											0:
												globals.levelStart=true
												get_tree().change_scene_to_file("scenes/attic3.tscn")
												endOfChat()
											1:
												globals.levelStart=true
												get_tree().change_scene_to_file("scenes/attic3.tscn")
												endOfChat()
											2:
												endOfChat(0)
						else:
							text_box.queue_text("but gabriel is still hungry")
							inChat=false
			"attic3":
				match npcName:
					"snitel":
						match npcConv:
							0:
								text_box.queue_questionResponse("CRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZYCRAZY")
								npcConv+=1
							1:
								text_box.queue_text("CRAZY?
								I WAS CRAZY ONCE.
								THEY LOCKED ME IN A ROOM.
								A RUBBER ROOM.
								A RUBBER ROOM WITH RATS.
								AND RATS MAKE ME CRAZY.")
								inChat=false
					"sussy":
						match npcConv:
							0:

								text_box.queue_text("dont get near me you filthy League of Legends player
								(i mean.......)
								(you smell really really bad)")
								endOfChat(npcConv+1)
					"flapjack2":
						match npcConv:
							0:
								globals.nearFlapjack2=true
								endOfChat(npcConv+1)
					"flapjack":
						match npcConv:
							0:
								text_box.queue_questionResponse("who are you and why are you in my home")
								text_box.queue_text("AAAAAAHHGGGGGHAAAAAAAHGGGGGGGHHHHHHH FLAPJACK
								*sounds of agony and pain*
								IIHHHHHHH PLYYYYYYYYYY HHYROOOOES OFFFFF DAAAAAA STROOOOOOOOOOOOOM
								(imagine playing Heroes of the Storm)")
								text_box.queue_questionResponse("so thats why you look like the Rake?")
								text_box.queue_text("(just my opinion but you look like mini-putin)")
								npcConv+=1
							1:
								if textReady():
									text_box.queue_text("flapjack started crying")
									globals.flapjackCry=true
									endOfChat(npcConv+1)
					"salami":
						match npcConv:
							0:
								text_box.queue_text("imagine sleeping 4 years")
								npcConv+=1
							1:
								if textReady():
									conversation(["where is Noodle Doodle-Doo",
									"have you ever thought about switching from windows to AmogOS?",
									"he got run over by a bicycle",
									"no
									i use LindowsOS"])
							2:
								endOfChat()
								
			"home1":
				match npcName:
					"bucket":
						match npcConv:
							0:
								text_box.queue_text("buckets")
								inChat=false
					"miguel":
						match npcConv:
							0:
								text_box.queue_text("(he is trembling either because her saw your biceps or he is poisoned)
								(imagine the next text as mumbling)
								bullets bulletsbulletsbullets bulletsbulletsbullets bullets bulletsbullets bulletsbullets 
								i need more of them (bullets)
								yes
								and bigger weapons (weapons)
								i love bigger weapons
								yes yes yes yes yes
								i need more bullets (and bigger weapons)")
								endOfChat(npcConv+1)

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
								if textReady():
									match text_box.IndexChosen:
										0:
											text_box.queue_text("you ate the raw potato
											it was full of dirt, but gabriel ate it anyway
											but gabriel is still hungry
											but there is no more food
											(imagine beeng poor)
											it might be amimir time (amimir = speel)")
											globals.knifeTaken=true
											endOfChat(npcConv+1)
										1:
											text_box.queue_text("you accidentally ate the raw potato
											it was full of dirt, but gabriel ate it anyway
											but gabriel is still hungry
											but there is no more food
											(imagine beeng poor)
											it might be amimir time (amimir = speel)")
											globals.knifeTaken=true
											endOfChat(npcConv+1)
										2:
											endOfChat(0)
					"veranda":
						match npcConv:
							0:
								text_box.queue_text(":)
								i am mommy")
								npcConv+=1
							1:
								conversation(["where is dad, mommy?",

								"hi mommy, give me food please",
								
								"when you were born, your dad wanted to shoot you
								the bullet came out a little and said \"i don't enter in in this thing\"
								he threw a grenade at you. it stopped in the air and said \"what more damage can i do to him?\"
								after some time he gave up and left",

								"you hungry?
								skill issue
								dont be hungry anymore"])
							2:
								endOfChat()
								
			"home2":
				match npcName:
					"veranda":
						match npcConv:
							0:
								text_box.queue_text("what do you want?")
								npcConv+=1
							1:
								if textReady():
									conversation(["food",

									"i want to play Raid Shadow Legends, one of the biggest mobile role-playing games of 2019 and it's totally free! Currently almost 10 million users have joined Raid over the last six months, and it's one of the most impressive games in its class with detailed models, environments and smooth 60 frames per second animations! All the champions in the game can be customized with unique gear that changes your strategic buffs and abilities! The dungeon bosses have some ridiculous skills of their own and figuring out the perfect party and strategy to overtake them's a lot of fun! Currently with over 300,000 reviews, Raid has almost a perfect score on the Play Store! The community is growing fast and the highly anticipated new faction wars feature is now live, you might even find my squad out there in the arena! It's easier to start now than ever with rates program for new players you get a new daily login reward for the first 90 days that you play in the game! So what are you waiting for? Go to the video description, click on the special links and you'll get 50,000 silver and a free epic champion as part of the new player program to start your journey! Good luck and I'll see you there!",

									":)
									(how can you respond to that?)
									(you cant)",
									
									"don't you want to suck my di--fast--0.04
									:)"])
							2:
								endOfChat()

					"bucket":
						match npcConv:
							0:
								text_box.queue_text("more buckets")
								inChat=false
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
								if textReady():
									match text_box.IndexChosen:
										0:
											text_box.queue_text("you ate the raw beans
											did you know that raw beans are toxic?
											...
											amimir time")
											globals.knifeTaken=true
											endOfChat(npcConv+1)
										1:
											text_box.queue_text("you accidentally ate the raw beans
											did you know that raw beans are toxic?
											...
											amimir time")
											globals.knifeTaken=true
											endOfChat(npcConv+1)
										2:
											endOfChat(0)
			"home3":
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
								endOfChat(npcConv+1)
					"veranda":
						match npcConv:
							0:
								text_box.queue_text("did you know cannibalism is not illegal?")
					"bucket":
						match npcConv:
							0:
								text_box.queue_text("even more buckets")
								inChat=false
					"knife":
						match npcConv:
							0:
								if globals.knifeTaken==false:
									text_box.queue_text("this is obviously a pen")
									text_box.queue_questionResponse("take the pen :)
									don't take the pen
									take the pen later")
									npcConv+=1
							1:
								if textReady():
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
									inChat=false
			"alley":
				match npcName:
					"cockroach":
						match npcConv:
							0:
								text_box.queue_text("big pile of cockroaches")
								text_box.queue_questionResponse(":)
								no thank you, im vegetarian")
								npcConv+=1
							1:
								if textReady():
									match text_box.IndexChosen:
										0:
											npcConv+=2
										1:
											text_box.queue_text("(should have thought about that before you ate your brother)")
											npcConv+=1
							2:
								if textReady():
									npcConv+=1
							3:
								text_box.queue_text("gabriel ate the huge pile of cockroaches with such an unnatural dexterity no cockroach escaped his furry")
								endOfChat()
								get_parent().queue_free()
					"garbage":
						match npcConv:
							0:
								text_box.queue_text("garbage")
								endOfChat()

		globals.convState[npcName+currentScene]=npcConv
		text_box.inChat=inChat


#give this function 5 statements and 5 responses (must be equal otherwise error) and after every response, kill the precedent statement							
func conversation(stringArray:Array[String],correctAnswers:Array[int]=[]):
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
			if textReady():
				text_box.queue_text(stringArray2[text_box.IndexChosen+stringArray2.size()/2])
				npcConv2-=1
				stringArray2.remove_at(text_box.IndexChosen+stringArray2.size()/2)
				stringArray2.remove_at(text_box.IndexChosen)

				if correctAnswers.has(text_box.IndexChosen):#if you chose the right answer continue
					npcConv+=1
				elif stringArray2.is_empty():
					npcConv+=777
				else:
					endOfChat()


func _on_area_2d_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearNpc=true


func _on_area_2d_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearNpc=false

func textReady():
	return text_box.current_state==text_box.State.ready

#use this only if you wont speak with the character any further
func endOfChat(npcConvv:int=-1):
	if  npcConvv!=-1:
		npcConv=npcConvv
	inChat=false
	if text_box.text_queue.is_empty() and text_box.conv_queue.is_empty(): #i should be executed for this
		text_box.hide_textbox()#this is morally wrong in many ways
		#the reason i do this is because in between some statements text text_box.current_state==text_box.State.ready and it makes the textbox disappear for 1 frame and it looks bad
#:):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):)
