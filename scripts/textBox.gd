extends CanvasLayer
class_name textBoxClass

const CHAR_READ_RATE = 0.03

@export var textureRect: TextureRect
@export var textbox_container: MarginContainer
@export var start_symbol: Label
@export var end_symbol: Label
@export var label: Label

enum State { ready, newText, reading, finished }
var current_state: State = State.ready
var text_queue: Array = []
var tween: Tween
var endOfConversation : bool = false


func _ready():
	hide_textbox()


#displays all the queued texts
func _process(delta):
	match current_state:
		State.ready:
			if !text_queue.is_empty():
				current_state = State.newText
		State.newText:
			if !text_queue.is_empty():
				end_symbol.text = ""
				displayText()
			else:
				current_state = State.ready
		State.reading:
			#ui_end must be set in godot
			if Input.is_action_just_pressed("ui_end"):
				label.visible_ratio = 1
				tween.kill()
				end_symbol.text = ":)"
				current_state = State.finished
		State.finished:
			#ui_accept must be set in godot
			if Input.is_action_just_pressed("ui_accept"):
				current_state = State.newText
				if text_queue.is_empty():
					hide_textbox()
					endOfConversation=true


func queue_text(next_text: String):
	text_queue.push_back(next_text)


#display 1 text at a time using tween
func displayText():
	show_textbox()
	var next_text: String = text_queue.pop_front()
	var parts := next_text.find("-")
	#below i make sure that the image of the character speaking is shown correctly or not at all
	if parts != -1:
		var before: String = next_text.substr(0, parts).strip_edges()
		var after: String = next_text.substr(parts + 1).strip_edges()
		setTexture(after)
		start_symbol.text = ""
		label.text = before
	else:
		label.text = next_text
		setTexture(null)
	label.visible_ratio = 0
	current_state = State.reading
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1, len(next_text) * CHAR_READ_RATE)
	tween.connect("finished", finishedTweening)


func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()


func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()


func finishedTweening():  #connedcted with tween's finished signal
	end_symbol.text = ":)"
	current_state = State.finished


func enableImage():
	textureRect.visible = true


func disableImage():
	textureRect.visible = false


func setTexture(texture):
	if texture == null:
		textureRect.texture = null
	else:
		textureRect.texture = load("res://sprites/" + texture + ".png")
