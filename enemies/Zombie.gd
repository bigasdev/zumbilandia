extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var offset : Vector2
export var staticPos : bool

export var health : int = 10
export var moveSpeed := 450
export var coins_to_drop := 3
export var damage := 5
export var damage_dist := 30

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

func kill(drop:bool) -> void:
	Global.camera.shake(0.15, 15, 30.1)
	if drop:
		var i = 0
		while i < coins_to_drop:
			var coin = self.coin.instance()
			coin.position = Global.get_entity_rnd_radius(self, Vector2.ZERO, Vector2(50,50))
			get_node("/root/MainScene/Game").add_child(coin)
			i += 1
	queue_free()

# Function that will make the zombie run to the player
func chase(player : Node2D) -> void:
	if staticPos:
		return

	var dir = (player.position - position).normalized()
	var velocity = dir * moveSpeed
	move_and_slide(velocity)

# Check if the player is inside the damage area
func player_on_range(dist:float) -> bool:
	if position.distance_to(Global.player.position) < dist:
		return true
	else:
		return false

func damage(dmg:int):
	health -= dmg
	animation.play("Blink")
	if health <= 0:
		kill(true)
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if StateManager.game_running():
		chase(Global.player)
		if player_on_range(damage_dist) && !staticPos:
			Global.damage_player(damage)
			kill(false)
	pass
