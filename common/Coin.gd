extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var sprite : Sprite = $Sprite
onready var collect_sound = $Collect_Sound
export var y_pos_limit : float = .5
export var float_speed : float = 3
export var move_speed : float = 15

var original_y_pos : float
var y_pos : float = 0
var float_state_up = false
var collected := false
var collided := false

# Called when the node enters the scene tree for the first time.
func _ready():
	original_y_pos = sprite.position.y
	pass # Replace with function body.

# Function that will make the coin sprite go up and down
func _move_coin(delta):
	if float_state_up:
		y_pos -= float_speed * delta
		if y_pos <= -y_pos_limit:
			float_state_up = false
			pass
		pass
	else :
		y_pos += float_speed * delta
		if y_pos >= y_pos_limit:
			float_state_up = true
			pass
		pass
	sprite.position = Vector2(sprite.position.x, original_y_pos + y_pos)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move_coin(delta)

	# If collided we move it to the player
	if collided:
		position = position.linear_interpolate(Global.player.position, move_speed * delta)
		if position.distance_to(Global.player.position) < 20:
			_collect()
			Global.player.collect()

	pass
	
func _collect() -> void:
	if collected:return

	collect_sound.play()
	collected = true
	sprite.visible = false
	Global.player_coins += 1
	Global.hud.update_hud()


func _on_Coin_body_entered(body):
	if body.is_in_group("Player"):
		collided = true
	pass # Replace with function body.


func _on_Collect_Sound_finished():
	queue_free()
	pass # Replace with function body.
