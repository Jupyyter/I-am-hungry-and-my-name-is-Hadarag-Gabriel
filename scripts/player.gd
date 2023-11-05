extends CharacterBody2D

class_name player

var speedMultiplier:float=1
var speed:int=75
var flipped:bool=false
var nearLadder:bool=false
var atticStartPos=Vector2i(147,227)
var inAnimation:bool=false
var lastNpcInteracted:String=""
@onready var timer:Timer=$Timer
@onready var animationPlayer:AnimationPlayer =$AnimationPlayer
@onready var collisionshape2D:CollisionShape2D =$CollisionShape2D
@onready var sprite2D:Sprite2D =$Sprite2D

func _ready():
	timer.stop()
	speedMultiplier=5

func _process(delta):
	get_input()

func _physics_process(delta):

	move_and_slide()

func get_input()->void:
	var input_direction :Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_direction=round(input_direction)
	velocity = input_direction * speed*speedMultiplier

	#dont move while the textbox is on
	if inAnimation or text_box.isOn():
		velocity=Vector2.ZERO
	
	print(lastNpcInteracted)
	if !text_box.inChat and globals.npcTriggered.has(lastNpcInteracted) and globals.npcRef[lastNpcInteracted]!=null and globals.npcTriggered[lastNpcInteracted]:
		globals.npcRef[lastNpcInteracted].queue_free()

	if globals.npcTriggered.has(lastNpcInteracted):
		print( globals.npcTriggered[lastNpcInteracted])
	
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

func animationReset(k:bool=true):
	if k:
		globals.playerAnimation="Normal"
	else:
		globals.playerAnimation="Blood1"
	inAnimation=false

#called when the animation ended
func _on_animation_player_animation_finished(anim_name:StringName):
	if anim_name.begins_with("idleEat"):
		audio.stopSound()
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
		"idleEatMundo":
			changeMode("Blood1")
		"idleEatIulica":
			changeMode("Blood1")
		"idleEatYuumi":
			changeMode("Blood1")
		"idleEatBeans":
			animationReset()
		"idleEatPotato":
			animationReset()
		"idleEatGarbage":
			animationReset()
		"idleEatStopSign":
			animationReset()
		"idleEatCockroach":
			animationReset()
		"idleEatWall":
			animationReset()

func intestinalBlockage():
	var tween:Tween
	tween=create_tween()
	tween.tween_property(self, "speedMultiplier", 0, 2).set_trans(Tween.TRANS_CUBIC)
	tween.connect("finished",fallOver)

func fallOver():
	timer.start()
	globals.getPlayer().changeMode("IntestinalBlockage")

func _on_timer_timeout():
	timer.stop()
	get_tree().change_scene_to_file("scenes/intro.tscn")
	globals.inHospital=true

#returnes true if gabriel is in an animation
func animationFinished()->bool:
	if globals.playerAnimation=="Blood0" or globals.playerAnimation=="Blood1" or globals.playerAnimation=="Normal":
		return true
	else:
		return false

#gabriel eats something :)
func eat(objectToEat:Node, sound:String="grapefruit", makeObjectDisappear:bool=true)->void:
	audio.playSound(sound)
	changeMode("Eat"+animationName(objectToEat.name))
	globals.npcTriggered[objectToEat.name]=true
	if makeObjectDisappear:
		globals.npcRef[objectToEat.name].visible=false
		lastNpcInteracted=objectToEat.name

#removes all the numbers and it makes the first letter capitalized
func animationName(input_string: String) -> String:
	if input_string.length() == 0:
		return input_string

	var sanitized_string = ""
	for i in range(input_string.length()):
		var char = input_string[i]
		if !char.is_valid_int() or char == ' ':
			sanitized_string += char

	if sanitized_string.length() == 0:
		return sanitized_string

	var first_letter = sanitized_string[0].to_upper()
	return first_letter + sanitized_string.substr(1, sanitized_string.length() - 1)
