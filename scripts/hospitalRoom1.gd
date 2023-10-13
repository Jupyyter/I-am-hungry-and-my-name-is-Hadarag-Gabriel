extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if globals.firstTime(self.name):
		text_box.queue_text("why do we have a homeless eating Tom in the hospital?
			sir, he is mister Gabriel, he once ate a brick wall, can i keep him?
			ok
			gabriel, sit
			he is well trained, you can keep him
			ty sir")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
