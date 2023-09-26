extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed : float = 15
export var direction : Vector2
var velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _move_bullet(delta):
	velocity = speed *direction * delta
	translate(velocity)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_move_bullet(delta)
	pass

func _on_Bullet_body_entered(body):
	if body.is_in_group("Zombie"):
		body.damage(Global.player.damage + PowerupManager.power_powerup)
		queue_free()
		pass
	pass # Replace with function body.

