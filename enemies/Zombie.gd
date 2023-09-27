extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var offset : Vector2
export var staticPos : bool

export var health : int = 10
export var moveSpeed := 450
export var coins_to_drop := 3

# Components
onready var animation = $AnimationPlayer
onready var coin = preload("res://common/Coin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if staticPos :
		return
	
	# get a random position based in an offset around the player
	position = Global.get_entity_rnd_radius(self, Vector2.ZERO, offset)
	pass # Replace with function body.

func kill() -> void:
	var i = 0
	while i < coins_to_drop:
		var coin = self.coin.instance()
		coin.position = Global.get_entity_rnd_radius(self, Vector2.ZERO, Vector2(50,50))
		get_node("/root/MainScene/Game").add_child(coin)
		i += 1
	queue_free()

func damage(dmg:int):
	health -= dmg
	animation.play("Blink")
	if health <= 0:
		kill()
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
