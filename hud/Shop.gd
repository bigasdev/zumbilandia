extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Variables
export var ammo_value := 100
export var health_value := 200
onready var weapon_icon = $Weapon/Icon
onready var weapon_label = $Weapon/Price
var weapon_value : int = 500

# array of weapon sprites
export var weapon_sprites = []

# Called when the node enters the scene tree for the first time.
func _ready():
	StateManager.change_state(StateManager.States.PAUSE)
	if weapon_sprites.size() < Global.weapon_number + 1 : weapon_icon.texture = weapon_sprites[Global.weapon_number+1]
	pass # Replace with function body.

# Function that will check if the Global.player_coins can afford a value
# If it can, it will subtract the value from the Global.player_coins
# and return true
# If it can't, it will return false
func check_coins(value):
	if Global.player_coins >= value:
		Global.player_coins -= value
		return true
	else:
		return false

# Function to buy ammo
func buy_ammo() -> void:
	if check_coins(ammo_value):
		Global.player_ammo += 50
		Global.hud.update_hud()
	else:
		print("Not enough coins")

func buy_weapon() -> void:
	if Global.weapon_number >= 6 : return
	if check_coins(weapon_value):
		Global.next_weapon()
		weapon_icon.texture = weapon_sprites[Global.weapon_number+1]
		weapon_value += 200
		weapon_label.text = str(weapon_value)
		Global.hud.update_hud()
	else:
		print("Not enough coins")

# Function to buy ammo
func buy_health() -> void:
	if Global.player_health >= 100:
		print("Health is full")
		return

	if check_coins(health_value):
		Global.player_health += 20
		Global.hud.update_hud()
	else:
		print("Not enough coins")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Esc_pressed():
	StateManager.change_state(StateManager.States.UPDATE)
	queue_free()
	pass # Replace with function body.


func _on_Health_Button_pressed():
	buy_health()
	pass # Replace with function body.

func _on_Ammo_Button_pressed():
	buy_ammo()
	pass # Replace with function body.


func _on_Weapon_Button_pressed():
	buy_weapon()
	pass # Replace with function body.
