extends Sprite2D

@export var animationPlayer:AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.npcTriggered["flapjack2"]==true:
		animationPlayer.play("noHead")

