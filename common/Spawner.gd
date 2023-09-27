extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# The object we need to instante
export var night_time_amount = 25

# Components
onready var night_timer = $NightTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.spawner = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if !StateManager.game_can_spawn(): return
	
	var zombie = preload("res://enemies/Zombie.tscn")
	add_child(zombie.instance())
	pass # Replace with function body.

func _on_CollectableTimer_timeout():
	if !StateManager.game_running(): return
	
	var collectable = preload("res://powerups/Collectable.tscn")
	collectable.randomize_spawn()
	add_child(collectable.instance())
	pass # Replace with function body.


func night_time():
	var i = 0
	StateManager.change_state(StateManager.States.UPDATE_IDLE)
	night_timer.start()
	while i < night_time_amount:
		var zombie = preload("res://enemies/Zombie.tscn")
		add_child(zombie.instance())
		i += 1
	pass


func _on_NightTimer_timeout():
	print_debug("Reseting the update method")
	StateManager.set_update()
	pass # Replace with function body.
