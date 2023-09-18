extends CharacterBody2D

class_name player

var speedMultiplier:int=3
var speed:int=150
var flipped:bool=false
var nearLadder:bool=false
var atticStartPos=Vector2i(147,227)
var inAnimation:bool=false
@onready var animationPlayer =$AnimationPlayer
@onready var collisionshape2D =$CollisionShape2D
@onready var sprite2D =$Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	get_input()

func _physics_process(delta):
	move_and_slide()

func get_input()->void:
	var input_direction :Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_direction=round(input_direction)
	velocity = input_direction * speed*speedMultiplier

	#dont move while the textbox is on
	if text_box.current_state!=text_box.State.ready or inAnimation:
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

func changeMode(mode:String):
	if ["Knife","Blood1","Blood0","EatRat","EatCat","EatFlapjack"].has(mode):
		globals.playerAnimation=mode

func animationReset():
	globals.playerAnimation=""

func _on_animation_player_animation_finished(anim_name:StringName):
	inAnimation=false
	match anim_name:
		"idleEatRat":
			changeMode("Blood0")
		"idleEatCat":
			changeMode("Blood1")
		"idleEatFlapjack":
			animationReset()
			get_tree().change_scene_to_file("scenes/intro.tscn")