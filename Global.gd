extends Node

var main_scene
var camera
var player : KinematicBody2D
var spawner : Node
var hud : CanvasLayer

const BORDER_X : int = 1500
const BORDER_Y : int = 1500

var player_health : int = 100
var player_ammo : int = 200
var player_coins : int = 0

var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func night_time():
	print_debug("its night time!")
	spawner.night_time()
	pass
	
func get_entity_rnd_radius(entity, radius=Vector2.ZERO, offset=Vector2.ZERO) -> Vector2:
	var vector = Vector2(radius.x, radius.y)
	rng.randomize()
	var offset_x = rng.randf_range(-offset.x, offset.x)
	var offset_y = rng.randf_range(-offset.y, offset.y)
	vector = Vector2(entity.global_position.x + offset_x, entity.global_position.y + offset_y)
	return vector
	

# Function to damage the player and check if its game over
func damage_player(damage) -> void:
	player_health -= damage
	Global.camera.shake(0.15, 15, 30.1)
	hud.update_hud()
	if player_health <= 0:
		game_over()

# Function for the game over
func game_over():
	print_debug("Game Over!")
	get_tree().reload_current_scene()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#	pass
