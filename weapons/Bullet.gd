extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed : float = 15
export var direction : Vector2
var velocity : Vector2

# Variables
export var life_timer := 3

# private
var life_time = 0

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
	
func _process(delta) -> void:
	life_time += 1 * delta
	if life_time >= life_timer:
		queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("Zombie"):
		body.damage(Global.player.damage + PowerupManager.power_powerup)
		queue_free()
		pass
	if body.is_in_group("Breakable"):
		body.destroy()
		queue_free()
		pass
	pass # Replace with function body.

