extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Variables
export var move_speed : float = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MoveTimer_timeout():
	# when the time out reaches 0 we will move the body to the left using the move speed
	move_and_slide(Vector2(-move_speed, 0))
	pass # Replace with function body.
