extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var npc : KinematicBody2D = $Npc
onready var zombies : Array = [$Zombie, $Zombie2, $Zombie3, $Zombie4, $Zombie5, $Zombie6]

onready var npc_object = preload("res://characters/Npc.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func player_rescue():
	for i in zombies:
		if is_instance_valid(i):
			i.queue_free()
		pass
	
	var npc_instance = npc_object.instance()
	npc_instance.position = npc.position
	
	npc.queue_free()
	
	get_node("/root/MainScene").add_child(npc_instance)
	npc_instance.set_following(Global.player)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rescue_body_entered(body):
	if body.is_in_group("Player"):
		player_rescue()
		pass
	pass # Replace with function body.
