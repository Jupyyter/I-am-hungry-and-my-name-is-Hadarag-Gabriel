extends Node2D
@export var house:Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if globals.nearFlapjack2:
		text_box.queue_text("this is Gabriel
		he is
		very
		very
		very
		hungry--red")
	else:
		text_box.queue_text("this is Gabriel
		intelligence: not much
		math skills: 3/10
		language in general: 1/10
		physique: very big
		note: he is very hungry
		quote: \"it's ok to like muscular men\"
		idk lets start--red")


func _process(delta):
	#called when the textBox has just finished showing an entire conversation
	if(text_box.current_state==text_box.State.ready):
		if globals.nearFlapjack2:
			if house.visible==true:
				get_tree().change_scene_to_file("scenes/alley.tscn")
			else:
				house.visible=true
				text_box.queue_text("after gabriel ate flapjack, he was kicked out from his home
				homeless? (imagine the blue large headed alien)
				oh wait
				homeless?--megamind
				what adventures awaits him outside?
				how many humans will he eat throughout the game?
				:)")
		else:
			get_tree().change_scene_to_file("scenes/attic1.tscn")
#its 4:24 AM, i havent slept yet and i have to go to school in 3 hours and 20 
#sleepless?