extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var shop = preload("res://hud/Shop.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Vendor_body_entered(body:Node):
	# check if is in the player group, if it is we instantiate the shop and queue free this npc
	if body.is_in_group("Player"):
		var shop_instance = shop.instance()
		get_parent().add_child(shop_instance)
		shop_instance.set_name("shop")
		queue_free()
	pass # Replace with function body.
