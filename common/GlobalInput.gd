extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pause = preload("res://hud/Pause.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		if !StateManager.game_running() : return;
		StateManager.change_state(StateManager.States.PAUSE)
		#instantiate the pause menu
		var pause_menu = pause.instance()
		#add the pause menu to the scene tree
		get_tree().get_root().add_child(pause_menu)
		pass
	if Input.is_action_just_pressed("debug"):Global.next_weapon()
	pass
