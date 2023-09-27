extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Components
onready var health = $Components/Health
onready var ammo = $Components/Ammo
onready var coins = $Components/Coins

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.hud = self
	update_hud()
	pass # Replace with function body.

func update_hud():
	health.text = String(Global.player_health)
	ammo.text = String(Global.player_ammo)
	coins.text = String(Global.player_coins)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	Global.night_time()
	pass # Replace with function body.
