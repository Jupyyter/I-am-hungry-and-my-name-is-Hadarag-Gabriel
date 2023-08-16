extends CanvasLayer
class_name textBoxClass

#the higher the number, the slower the text will appear
const CHAR_READ_RATE = 0.3

@export var textureRect: TextureRect
@export var textbox_container: MarginContainer
@export var start_symbol: Label
@export var end_symbol: Label
@export var label: Label
@export var boxContainer:HBoxContainer

var IndexChosen:int=0
var lastIndexChosen:int=0

enum State { ready, newText, reading, finished }
var current_state: State = State.ready
var text_queue: Array = []
var tween: Tween
var chooseMode:bool=false
var endOfConversation : bool = false
var doStuff1FrameLater:bool=false

var LabelList2:Array[Label]
var currentStateList2:Array[State]
var LabelList:Array[Label]
var currentStateList:Array[State]

func _ready():

	hide_textbox()


#displays all the queued texts
func _process(delta):
	choosingResponse()
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
						#DELETE ALL THE CHILDREN DIEDIEDIEDIEDIE
						#GABRIEL EATING MY MEMORY HAHAHAHAHAHAHAHAAHAHAHAHAHAHAHAAHAHAHAHAHAHAAHAHA
						findThingInNode(lbl,boxContainer).queue_free()
						currentStateList.erase(currentStateList[LabelList.find(lbl)])
						LabelList.erase(lbl)
						if LabelList.is_empty():
							doStuff1FrameLater=true
							LabelList2=[]
							currentStateList2=[]
							hide_textbox()
							endOfConversation=true
							chooseMode=false



func queue_text(next_text: String)->void:
	var lines:PackedStringArray = next_text.split("\n")
	initializeNewLabel()
	for line in lines:
		text_queue.push_back(line)

func queue_questionResponse(next_text: String)->void:
	IndexChosen=0
	lastIndexChosen=0
	chooseMode=true
	var lines:PackedStringArray = next_text.split("\n")
	for line in lines:
		text_queue.push_back(line)
		initializeNewLabel()

#display 1 text at a time using tween, changes texture and the color accordingly
func displayText(lbl:Label)->void:
	show_textbox()
	var next_text: String = text_queue.pop_front()
	for i in next_text.count("-")+1:
		var parts:int = next_text.find("-")
		#dealing with the text properties (like colored text)
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
	tween.tween_property(lbl, "visible_ratio", 1, CHAR_READ_RATE)
	tween.connect("finished", finishedTweening )


func hide_textbox()->void:
	start_symbol.text = ""
	end_symbol.text = ""
	textbox_container.hide()


func show_textbox()->void:
	start_symbol.text = "*"
	textbox_container.show()


func finishedTweening()->void:  #connedcted with tween's finished signal
	end_symbol.text = ":)"
	for lbl in LabelList2:
		currentStateList[LabelList.find(lbl)] = State.finished
		currentStateList2[LabelList2.find(lbl)] = State.finished


func enableImage()->void:
	textureRect.visible = true


func disableImage()->void:
	textureRect.visible = false


func setTexture(texture)->void:
	if texture == null:
		textureRect.texture = null
	else:
		textureRect.texture = load("res://images/" + texture + ".png")

func colorRed(lbl:Label)->void:
	#lbl.add_theme_color_override("font_color",Color(180,0,0))
	lbl.add_theme_color_override("font_color",Color(180,0,0))

func colorReset(lbl:Label)->void:
	#lbl.add_theme_color_override("font_color",Color.WHITE)
	lbl.add_theme_color_override("font_color",Color.WHITE)

func initializeNewLabel()->void:

	var lblInstance=label.duplicate()
	lblInstance.show()
	LabelList.push_back(lblInstance)
	boxContainer.add_child(lblInstance)
	boxContainer.move_child(lblInstance,boxContainer.get_child_count()-2)
	LabelList2=LabelList.duplicate()

	var stateInstance:State=State.ready
	currentStateList.push_back(stateInstance)
	currentStateList2=currentStateList.duplicate()

func choosingResponse()->int:
	if(!chooseMode):
		return 0
	
	if Input.is_action_just_pressed("ui_right"):
		IndexChosen+=1
	if Input.is_action_just_pressed("ui_left"):
		IndexChosen-=1
	if IndexChosen > LabelList2.size()-1:
		IndexChosen=LabelList2.size()-1
	elif IndexChosen < 0:
		IndexChosen=0
	LabelList2[IndexChosen].add_theme_stylebox_override("normal",createStyleBox())
	if(IndexChosen!=lastIndexChosen):
		LabelList2[lastIndexChosen].remove_theme_stylebox_override("normal")
		lastIndexChosen=IndexChosen
	print(IndexChosen)
	return IndexChosen

func findThingInArray(lbl: Node, arr: Array) -> Node:
	for labell in arr:
		if labell == lbl:
			return labell
	return null

#returns a reference to the child of the node
func findThingInNode(child:Node,nod2:Node)->Node:
	for thing in nod2.get_children():
		if thing==child:
			return child
	return null

func createStyleBox():
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(183, 196, 67)
	style_box.border_color = Color("B7C443")
	style_box.draw_center=false
	style_box.set_border_width_all(2)
	style_box.set_content_margin_all(0)
	style_box.set_expand_margin_all(4)
	return style_box
