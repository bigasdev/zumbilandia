extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var sprite : Sprite = $Sprite
export var y_pos_limit : float = .5
export var float_speed : float = 3

var original_y_pos : float
var y_pos : float = 0
var float_state_up = false

# Called when the node enters the scene tree for the first time.
func _ready():
	original_y_pos = sprite.position.y
	pass # Replace with function body.

# Function that will make the coin sprite go up and down
func _move_coin(delta):
	if float_state_up:
		y_pos -= float_speed * delta
		if y_pos <= -y_pos_limit:
			float_state_up = false
			pass
		pass
	else :
		y_pos += float_speed * delta
		if y_pos >= y_pos_limit:
			float_state_up = true
			pass
		pass
	sprite.position = Vector2(sprite.position.x, original_y_pos + y_pos)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move_coin(delta)
	pass
