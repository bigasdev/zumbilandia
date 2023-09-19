extends Control

onready var hud : CanvasLayer = $HUD
onready var menu : Control = $Menu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.main_scene = self
	pass # Replace with function body.

func _change_main_elements(state):
	menu.visible = state
	pass
	
func _load_game():
	var game = preload("res://levels/Game.tscn")
	add_child(game.instance())
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_pressed():
	_change_main_elements(false)
	hud.visible = true
	_load_game()
	pass # Replace with function body.


func _on_Pause_pressed():
	StateManager.change_state(StateManager.States.PAUSE)
	pass # Replace with function body.
