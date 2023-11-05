extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for trigger in globals.npcTriggered.keys():
		if globals.npcTriggered[trigger]:
			globals.npcTriggered[trigger]=false
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
