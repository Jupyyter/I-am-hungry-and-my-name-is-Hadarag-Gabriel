extends CharacterBody2D

class_name player

var speedMultiplier:float=5
var speed:int=150
var flipped:bool=false
var nearLadder:bool=false
var atticStartPos=Vector2i(147,227)
var inAnimation:bool=false
var intestinalBlockage:bool=false
@onready var timer:Timer=$Timer
@onready var animationPlayer:AnimationPlayer =$AnimationPlayer
@onready var collisionshape2D:CollisionShape2D =$CollisionShape2D
@onready var sprite2D:Sprite2D =$Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.stop()
	speedMultiplier=5


func _process(delta):
	get_input()

func _physics_process(delta):
	if intestinalBlockage:
		speedMultiplier-=0.1
		if speedMultiplier<=0:
			intestinalBlockage=false
			speedMultiplier=0
			timer.start()
	move_and_slide()

func get_input()->void:
	var input_direction :Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_direction=round(input_direction)
	velocity = input_direction * speed*speedMultiplier

	#dont move while the textbox is on
	if inAnimation or text_box.isOn():
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
	if animationPlayer.get_animation_list().has("idle"+mode) or animationPlayer.get_animation_list().has("walk"+mode):
		globals.playerAnimation=mode
		if mode.begins_with("Eat"):
			inAnimation=true

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
		"idleEatBasketOfSnakes":
			animationReset()
		"idleEatBasketOfApples":
			animationReset()
		"idleEatBasketOfRocks":
			animationReset()
		"idleEatBasketOfMetal":
			animationReset()
		"idleEatBasketOfCorks":
			animationReset()
		"idleIntestinalBlockage":
			animationReset()
			get_tree().change_scene_to_file("scenes/hospitalRoom1.tscn")

func _on_timer_timeout():
	timer.stop()
	globals.getPlayer().changeMode("IntestinalBlockage")
	globals.inHospital=true
