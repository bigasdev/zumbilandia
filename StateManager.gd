extends Node

enum States {IDLE, UPDATE, UPDATE_IDLE, PAUSE}
var current_state = States.UPDATE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func change_state(state):
	current_state = state
	pass
	
func set_update() -> void:
	current_state = States.UPDATE

func game_running():
	return current_state == States.UPDATE || States.UPDATE_IDLE
	pass

func game_can_spawn() -> bool:
	return current_state == States.UPDATE

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
