extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# The object we need to instante


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if !StateManager.game_running(): return
	
	var npc = preload("res://characters/Npc.tscn")
	add_child(npc.instance())
	pass # Replace with function body.
