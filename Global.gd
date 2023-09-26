extends Node

var main_scene
var player : KinematicBody2D
var spawner : Node
var hud : CanvasLayer

var player_health : int = 100
var player_ammo : int = 200
var player_coins : int = 0

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
