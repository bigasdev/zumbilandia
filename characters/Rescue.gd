extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var npc : KinematicBody2D = $Npc
onready var zombies : Array = [$Zombie, $Zombie2, $Zombie3, $Zombie4, $Zombie5, $Zombie6]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func player_rescue():
	for i in zombies:
		if is_instance_valid(i):
			i.queue_free()
		pass
	npc.set_following(Global.player)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rescue_body_entered(body):
	if body.is_in_group("Player"):
		player_rescue()
		pass
	pass # Replace with function body.
