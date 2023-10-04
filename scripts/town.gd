extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for trigger in globals.npcTriggered.keys():
		if globals.npcTriggered[trigger]:
			match trigger:
				"stranger1":
					if text_box.current_state==text_box.State.ready:
						globals.npcRef[trigger].position.y-=25
				"stranger2":
					if text_box.current_state==text_box.State.ready:
						globals.npcRef[trigger].position.y-=25
				"stranger3":
					if text_box.current_state==text_box.State.ready:
						globals.npcRef[trigger].position.y-=25
				"basketOfApples":
					globals.getPlayer().changeMode("EatBasketOfApples")
					globals.npcRef[trigger].visible=false
				"basketOfCorks":
					globals.getPlayer().changeMode("EatBasketOfCorks")
					globals.npcRef[trigger].visible=false
				"basketOfRocks":
					globals.getPlayer().changeMode("EatBasketOfRocks")
					globals.npcRef[trigger].visible=false
				"basketOfMetal":
					globals.getPlayer().changeMode("EatBasketOfMetal")
					globals.npcRef[trigger].visible=false
				"basketOfSnakes":
					globals.getPlayer().changeMode("EatBasketOfSnakes")
					globals.npcRef[trigger].visible=false
				"basketOfApples2":
					globals.getPlayer().changeMode("EatBasketOfApples")
					globals.npcRef[trigger].visible=false
				"basketOfCorks2":
					globals.getPlayer().changeMode("EatBasketOfCorks")
					globals.npcRef[trigger].visible=false
				"basketOfRocks2":
					globals.getPlayer().changeMode("EatBasketOfRocks")
					globals.npcRef[trigger].visible=false
				"basketOfMetal2":
					globals.getPlayer().changeMode("EatBasketOfMetal")
					globals.npcRef[trigger].visible=false
				"basketOfSnakes2":
					globals.getPlayer().changeMode("EatBasketOfSnakes")
					globals.npcRef[trigger].visible=false
				"basketOfSnakes3":
					globals.getPlayer().changeMode("EatBasketOfSnakes")
					globals.npcRef[trigger].visible=false
			globals.npcTriggered[trigger]=false
