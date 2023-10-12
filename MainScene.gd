extends Control

onready var hud : CanvasLayer = $HUD
onready var menu : Control = $Menu
onready var counter : Label = $HUD/Main_HUD/Counter
onready var counter_timer : Timer = $HUD/Main_HUD/Counter/Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game_started = false

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
	game_started = true
	counter_timer.start()
	pass

func _change_counter():
	if !counter_timer.is_stopped() : counter.text = String(counter_timer.time_left).pad_decimals(0)
	else : 
		# get node with the group "night_timer"
		var night_timer = get_tree().get_nodes_in_group("night_timer")
		if night_timer : 
			counter.text = String(night_timer[0].time_left).pad_decimals(0)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	_change_counter()
	pass


func _on_Start_pressed():
	_change_main_elements(false)
	hud.visible = true
	Global.reset()
	_load_game()
	pass # Replace with function body.


func _on_Pause_pressed():
	StateManager.change_state(StateManager.States.PAUSE)
	pass # Replace with function body.


func _on_Timer_timeout():
	Global.night_time()
	counter_timer.stop()
	counter.text = ""
	counter.text = "Night time!"
	pass # Replace with function body.


func _on_Exit_pressed():
	#exit the game:
	get_tree().quit()
	pass # Replace with function body.
