extends CharacterBody2D

class_name player

var speedMultiplier:int=3
var speed:int=150
var flipped:bool=false
var nearLadder:bool=false
var atticStartPos=Vector2i(147,227)
@onready var animationPlayer =$AnimationPlayer
@onready var collisionshape2D =$CollisionShape2D
@onready var sprite2D =$Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	get_input()
	if(nearLadder):
		if(Input.is_action_just_pressed("ui_accept")):
			get_tree().change_scene_to_file("scenes/home1.tscn")

func _physics_process(delta):
	move_and_slide()

func get_input()->void:
	var input_direction :Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_direction=round(input_direction)
	velocity = input_direction * speed*speedMultiplier

	#dont move while the textbox is on
	if text_box.current_state!=text_box.State.ready:
		velocity=Vector2.ZERO
	
	if velocity!=Vector2(0,0):
		if input_direction.x<0:
			flipped=true
		elif input_direction.x!=0:  
			flipped=false
		animationPlayer.play("walk"+globals.playerAnimation)
	else:
		animationPlayer.play("idle"+globals.playerAnimation)
	
	if(flipped):
		sprite2D.scale.x=-1
		collisionshape2D.scale.x=-1
	else:
		sprite2D.scale.x=1
		collisionshape2D.scale.x=1

func animationChange(mode:String):
	if mode=="Knife":
		globals.playerAnimation=mode
	elif mode=="Blood":
		globals.playerAnimation=mode

func animationReset():
	globals.playerAnimation=""