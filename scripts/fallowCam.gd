# Called when the node enters the scene tree for the first time.
extends Camera2D

@export var map: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	defineSpriteLimit(map)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func defineSpriteLimit(mapp:Sprite2D):
	var mapSize=mapp.texture
	limit_right=int(mapSize.get_width()*mapp.scale.x)
	limit_bottom=int(mapSize.get_height()*mapp.scale.y)

func defineTileMapLimit(mapp:TileMap):
	var mapRect = mapp.get_used_rect()
	var tileSize = mapp.cell_quadrant_size * 2
	var worldSizeInPixels = mapRect.size * tileSize
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y
