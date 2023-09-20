extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var damage : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Function that will set the damage of the weapon based in the character\
func set_damage(damage):
	self.damage = damage
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
