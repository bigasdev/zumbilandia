extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Variables
export var time_to_destroy := .3
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _destroy() -> void:
	get_parent().queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += 1 * delta
	if timer >= time_to_destroy:
		_destroy()
	pass
