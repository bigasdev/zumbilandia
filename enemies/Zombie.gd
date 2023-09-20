extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var offset : Vector2

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# get a random position based in an offset around the player
	rng.randomize()
	var offset_x = rng.randf_range(-offset.x, offset.x)
	var offset_y = rng.randf_range(-offset.y, offset.y)
	position = Global.player.position + Vector2(offset_x, offset_y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
