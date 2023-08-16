extends CanvasLayer
class_name textBoxClass

const CHAR_READ_RATE = 0.03

@export var textureRect: TextureRect
@export var textbox_container: MarginContainer
@export var start_symbol: Label
@export var end_symbol: Label
@export var label: Label
@export var boxContainer:HBoxContainer
var state1:State


enum State { ready, newText, reading, finished }
var current_state: State = State.ready
var text_queue: Array = []
var tween: Tween
var endOfConversation : bool = false
var doStuff1FrameLater:bool=false
var LabelList:Array[Label]
var LabelList2:Array[Label]
var currentStateList:Array[State]
var currentStateList2:Array[State]


func _ready():


	hide_textbox()


#displays all the queued texts
func _process(delta):
	if doStuff1FrameLater:
		current_state=State.ready
		doStuff1FrameLater=false
	for lbl in LabelList2:
		match currentStateList2[LabelList2.find(lbl)]:
			State.ready:
				if !text_queue.is_empty():
					currentStateList2[LabelList2.find(lbl)] = State.newText
					current_state= State.newText
			State.newText:
				if !text_queue.is_empty():
					end_symbol.text = ""
					colorReset(lbl)
					displayText(lbl)
				else:
					currentStateList2[LabelList2.find(lbl)] = State.ready
					current_state= State.ready
			State.reading:
				#ui_end must be set in godot
				if Input.is_action_just_pressed("ui_end"):
					label.visible_ratio = 1
					tween.kill()
					end_symbol.text = ":)"
					currentStateList2[LabelList2.find(lbl)] = State.finished
					current_state= State.finished
			State.finished:
				#ui_accept must be set in godot
				if Input.is_action_just_pressed("ui_accept"):
					currentStateList2[LabelList2.find(lbl)] = State.newText
					current_state= State.newText
					if text_queue.is_empty():
						doStuff1FrameLater=true
						hide_textbox()
						endOfConversation=true
						#DELETE ALL THE CHILDREN DIEDIEDIEDIEDIE
						#GABRIEL EATING MY MEMORY HAHAHAHAHAHAHAHAAHAHAHAHAHAHAHAAHAHAHAHAHAHAAHAHA
						findThingInNode2d(lbl,boxContainer).queue_free()
						currentStateList.erase(currentStateList[LabelList.find(lbl)])
						LabelList.erase(lbl)
						if LabelList.is_empty():
							LabelList2=LabelList.duplicate()
							currentStateList2=currentStateList.duplicate()


func queue_text(next_text: String):
	var lines:PackedStringArray = next_text.split("\n")
	initializeNewLabel()
	for line in lines:
		text_queue.push_back(line)

func queue_questionResponse(next_text: String):
	var lines:PackedStringArray = next_text.split("\n")
	for line in lines:
		text_queue.push_back(line)
		initializeNewLabel()

#display 1 text at a time using tween, changes texture and the color accordingly
func displayText(lbl:Label):
	show_textbox()
	var next_text: String = text_queue.pop_front()
	for i in next_text.count("-")+1:
		var parts:int = next_text.find("-")
		#below i make sure that the image of the character speaking is shown correctly or not at all
		if parts != -1 or i!=0:
			var after: String = next_text.substr(parts + 1).strip_edges()
			var before: String= next_text.substr(0, parts).strip_edges()
			next_text=after
			#idk
			match i:
				0:
					lbl.text = before
					setTexture(null)
				1:
					if before=="red":
						text_box.colorRed(lbl)
				2: 
					setTexture(before)
					start_symbol.text = ""
					
		elif i==0:
			lbl.text = next_text
			setTexture(null)
	#basically makes the text tween instead of spawning
	lbl.visible_ratio = 0
	currentStateList[LabelList.find(lbl)]  = State.reading
	currentStateList2=currentStateList.duplicate()
	tween = create_tween()
	tween.tween_property(lbl, "visible_ratio", 1, len(next_text) * CHAR_READ_RATE)
	tween.connect("finished", finishedTweening )


func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	textbox_container.hide()


func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()


func finishedTweening():  #connedcted with tween's finished signal
	end_symbol.text = ":)"
	for lbl in LabelList2:
		currentStateList[LabelList.find(lbl)] = State.finished
		currentStateList2[LabelList2.find(lbl)] = State.finished


func enableImage():
	textureRect.visible = true


func disableImage():
	textureRect.visible = false


func setTexture(texture):
	if texture == null:
		textureRect.texture = null
	else:
		textureRect.texture = load("res://images/" + texture + ".png")

func colorRed(lbl:Label):
	lbl.add_theme_color_override("font_color",Color(180,0,0))

func changeTextColor(text:Color,lbl:Label):
	lbl.add_theme_color_override("font_color",text)

func colorReset(lbl:Label):
	lbl.add_theme_color_override("font_color",Color.WHITE)

func initializeNewLabel():
	var lblInstance=label.duplicate()
	lblInstance.show()
	LabelList.push_back(lblInstance)
	boxContainer.add_child(lblInstance)
	boxContainer.move_child(lblInstance,boxContainer.get_child_count()-2)
	var stateInstance:State=State.ready
	currentStateList.push_back(stateInstance)
	LabelList2=LabelList.duplicate()
	currentStateList2=currentStateList.duplicate()

func findThingInArray(arr: Array, lbl: Label) -> Label:
	for label in arr:
		if label == lbl:
			return label
	return null

func findThingInNode2d(search:Label,nod2:HBoxContainer):
	for thing in nod2.get_children():
		if thing==search:
			return search
