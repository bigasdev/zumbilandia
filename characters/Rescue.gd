extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var npc : KinematicBody2D = $Npc
onready var black_npc : KinematicBody2D = $NpcBlack
onready var zombies : Array = [$Zombie, $Zombie2, $Zombie3, $Zombie4, $Zombie5, $Zombie6]

onready var npc_object = preload("res://characters/Npc.tscn")
onready var black_npc_object = preload("res://characters/NpcBlack.tscn")

var selected_npc : KinematicBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	selected_npc = get_black_or_white_npc()
	selected_npc.visible = true
	pass # Replace with function body.

func get_black_or_white_npc():
	var random = randi() % 2
	if random == 0:
		return npc
	else:
		return black_npc
	pass

func player_rescue():
	for i in zombies:
		if is_instance_valid(i):
			i.queue_free()
		pass
		
	var npc_instance
	if selected_npc == black_npc:
		npc_instance = black_npc_object.instance()
	else:
		npc_instance = npc_object.instance()
	npc_instance.position = npc.global_position
	
	selected_npc.queue_free()
	
	get_node("/root/MainScene/Game").add_child(npc_instance)
	Global.player.rescue(npc_instance)
	queue_free()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rescue_body_entered(body):
	if body.is_in_group("Player"):
		player_rescue()
		pass
	pass # Replace with function body.
