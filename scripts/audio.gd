extends AudioStreamPlayer

@export var textSound:AudioStreamPlayer
@export var grapefruit:AudioStream
@export var wakeUp:AudioStream
@export var moan:AudioStream
var playbackPosition:float = 0

func _ready():
	pass # Replace with function body.


func _process(delta):
	#if text is shown, play text sound
	if !textSound.playing and text_box.isReading():
		textSound.stream=load("res://sounds/skeleton/skeleton"+str(randi_range(1,11))+".wav")
		textSound.play()

func playSound(sound:String="grapefruit"):
	stream=load("res://sounds/"+sound+".mp3")
	play(playbackPosition)

func stopSound():
	playbackPosition=get_playback_position()
	stop()

func textSoundFinished():
	if text_box.isReading():
		textSound.stream=load("res://sounds/skeleton/skeleton"+str(randi_range(1,11))+".wav")
		textSound.play()


