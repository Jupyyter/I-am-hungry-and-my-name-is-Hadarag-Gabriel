extends Node2D
var npcConv:int=0

func _ready():
	if globals.firstTime(self.name):
		globals.getPlayer().changeMode("EatCatUp")
		globals.getPlayer().position=Vector2(-76,45)
	else:
		npcConv=4

func _process(delta):
	match npcConv:
		0:
			text_box.queue_text("why do we have a homeless eating Tom in the hospital?--color1
				sir, he is mister Gabriel, he once ate a brick wall, can i keep him?--color2
				gabriel, sit--color1")
			npcConv+=1
		1:
			if textReady():
				globals.getPlayer().changeMode("EatCatDown")
				text_box.queue_text("good gabriel--color1
					now bark--color1")
				text_box.queue_questionResponse("wof wooof WoOF OWOf OWFO WOF WOOFFFF WOOOOOOOOOOFFF")
				text_box.queue_text("he is well trained, you can keep him--color1
					ty sir--color2")
				npcConv+=1
		2:
			if textReady():
				globals.getPlayer().animationReset(false)
				npcConv+=1

func textReady():
	return text_box.current_state==text_box.State.ready