extends Node2D

var nearLadder:bool=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(nearLadder):
		if(Input.is_action_just_pressed("ui_accept")):
			get_tree().change_scene_to_file("scenes/lvl1.tscn")





func _on_ladder_body_exited(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=false

func _on_ladder_body_entered(body:Node2D):
	if body is CharacterBody2D:
		nearLadder=true
