extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var values := Vector2(0.08, 0.20)
export var blink_speed : float = 1
export var can_blink := false

var blink := false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Function that will make the texture scale value blink from 0.08 to 0.20
func blink_texture(delta):
	if blink:
		if texture_scale < values.y:
			texture_scale += blink_speed * delta
		else:
			blink = false
	else:
		if texture_scale > values.x:
			texture_scale -= blink_speed * delta
		else:
			blink = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_blink:blink_texture(delta)
	pass
