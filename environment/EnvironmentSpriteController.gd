extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_random_animated()
	pass # Replace with function body.

# Function that will get the parent animatedsprite child and change the animation from "idle" or "idle1" randomly
# It will change the speed from 3 fps to 10 fps randomly too
func sprite_random_animated() -> void:
	var animatedsprite = get_parent().get_node("AnimatedSprite")
	var random = randi()%2
	if random == 0:
		animatedsprite.set_animation("idle")
	else:
		animatedsprite.set_animation("idle1")
	# Change the speed scale with a min of 0.75 and a max of 1.KEY_5
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	animatedsprite.set_speed_scale(rng.randf_range(0.35, 1.5))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
