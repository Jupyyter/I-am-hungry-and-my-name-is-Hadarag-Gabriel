extends CharacterBody2D

var speed:int=150
var animation_name:String="Down"
var flipped:bool=false
var nearLadder:bool=false
@onready var animationPlayer =$AnimationPlayer
@onready var collisionshape2D =$CollisionShape2D
@onready var sprite2D =$Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	get_input()
	move_and_slide()
	if(nearLadder):
		if(Input.is_action_just_pressed("ui_accept")):
			get_tree().change_scene_to_file("scenes/lvl2.tscn")

func get_input():
	var input_direction :Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

	#dont move while the textbox is on
	if text_box.current_state!=text_box.State.ready:
		velocity=Vector2.ZERO
	
	
	if velocity!=Vector2(0,0):
		if input_direction.x<0:
			flipped=true
		elif input_direction.x!=0: 
			flipped=false
		animationPlayer.play("walk")
	else:
		animationPlayer.play("idle")
	
	if(flipped):
		sprite2D.scale.x=-1
		collisionshape2D.scale.x=-1
	else:
		sprite2D.scale.x=1
		collisionshape2D.scale.x=1

"""
func get_animation_name(input_direction):
	var idk:String=""
	
	if input_direction.x!=0:
		idk="walk"
		if input_direction.x<0:
			flipped=true
		else: 
			flipped=false
	else:
		idk="idle"
	return idk
"""

