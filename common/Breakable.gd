extends Node2D

enum BreakableType {CHEST = 0, AMMO_BOX = 1}

export(BreakableType) var type

# loads
onready var chest_sprite = preload("res://common/Chest.png")
onready var ammo_box_sprite = preload("res://common/AmmoBox.png")

# components
onready var collectable = preload("res://powerups/Collectable.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func destroy() -> void:
	var collectable_instance = collectable.instance()
	get_node("/root/MainScene/Game").add_child(collectable_instance)
	collectable_instance.position = position
	queue_free()
	if type == BreakableType.CHEST:
		collectable_instance.randomize_spawn()
		pass
	if type == BreakableType.AMMO_BOX:
		collectable_instance.set_type(2)
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
