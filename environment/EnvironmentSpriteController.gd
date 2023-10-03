extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Export var that will contain an array of textures
export var textures := []
export var has_animated_sprite := true

export(Array, NodePath) var sprites := []
export var sprites_max := 2
var current_sprites = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_animated_sprite : sprite_random_animated()
	else : sprite_random()
	if sprites.size() != 0 : hide_random()
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

# Function that will change the sprite randomly from the array of textures
func sprite_random() -> void:
	var sprite = get_parent().get_node("Sprite")
	var random = randi()%textures.size()
	sprite.set_texture(textures[random])

# Function that will loop in all the sprites node and randomly make it not visible
func hide_random() -> void:
	for sprite in sprites:
		var random = randi()%2
		if current_sprites >= sprites_max:
			break
		if random == 0:
			var n = get_node(sprite)
			current_sprites += 1
			n.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
