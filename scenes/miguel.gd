extends Sprite2D

var oroginalOffset:Vector2=self.offset

func _ready():
	pass # Replace with function body.

func _process(delta):
	shiver()

func shiver():
	self.offset=random_vector2()+oroginalOffset

func random_vector2():
	return Vector2(randf_range(-0.8, 0.8), randf_range(-0.8, 0.8))