extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		StateManager.change_state(StateManager.States.PAUSE)
		pass
	if Input.is_action_just_pressed("debug"):Global.next_weapon()
	pass
