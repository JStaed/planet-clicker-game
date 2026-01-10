extends Control


var score: int = 0
var score_increment: int = 1
var score_per_second: int = 0

var selected_sprite: int = 0

var shop_1_upgrades = [
	1,
	5,
	100
]
var shop_1_prices = [
	50,
	500,
	100000
]
var shop_1_levels = [
	0,
	0,
	0
]

var shop_2_upgrades = [
	1,
	5,
	10
]
var shop_2_prices = [
	2500,
	50000,
	200000
]
var shop_2_levels = [
	0,
	0,
	0
]

var unlocked_sprites = [
	true,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false
]
var sprite_prices = [
	0,
	1000,
	50000,
	250000,
	1000000,
	10000000,
	100000000,
	500000000,
	1000000000,
	9999999999
]
@onready var planet_sprites = [
	preload("res://planet-sprites/planet00.png"),
	preload("res://planet-sprites/planet01.png"),
	preload("res://planet-sprites/planet02.png"),
	preload("res://planet-sprites/planet03.png"),
	preload("res://planet-sprites/planet04.png"),
	preload("res://planet-sprites/planet05.png"),
	preload("res://planet-sprites/planet06.png"),
	preload("res://planet-sprites/planet07.png"),
	preload("res://planet-sprites/planet08.png"),
	preload("res://planet-sprites/planet09.png")
]

func _on_click_planet() -> void: # Increments score by increment value when the planet is clicked
	if unlocked_sprites[selected_sprite]:
		score += score_increment * (1 + selected_sprite)
		update_score()

func _cycle_planet_sprite_forward() -> void:
	selected_sprite = increment_clamped(selected_sprite, 0, 9)
	update_planet_sprite()

func _cycle_planet_sprite_backward() -> void:
	selected_sprite = increment_clamped(selected_sprite, 0, 9, -1)
	update_planet_sprite()	

func _purchase_planet_sprite():
	if score >= sprite_prices[selected_sprite]:
		score -= sprite_prices[selected_sprite]
		unlocked_sprites[selected_sprite] = true
		update_score()
		update_planet_sprite()

func purchase_upgrade(shopID: int, upgradeID: int):
	pass

func update_score():
	$CanvasContainer/Middle/ScoreLabel.text = "Score: " + str(score)

func update_shops():
	$CanvasContainer/Left/ShopButton.text = "Satellite: lvl " + str(shop_1_levels[0]) + " | Cost " + shop_1_prices[0]
	$CanvasContainer/Left/ShopButton.text = "Rover: lvl " + str(shop_1_levels[1]) + " | Cost " + shop_1_prices[1]
	$CanvasContainer/Left/ShopButton.text = "Rocket: lvl " + str(shop_1_levels[2]) + " | Cost " + shop_1_prices[2]
	$CanvasContainer/Left/ShopButton.text = "Colony: lvl " + str(shop_2_levels[0]) + " | Cost " + shop_2_prices[0]
	$CanvasContainer/Left/ShopButton.text = "Research Lab: lvl " + str(shop_2_levels[1]) + " | Cost " + shop_2_prices[1]
	$CanvasContainer/Left/ShopButton.text = "City: lvl " + str(shop_2_levels[2]) + " | Cost " + shop_2_prices[2]

func increment_clamped(base: int, value_min: int, value_max: int, increment: int = 1) -> int:
	base += increment
	if base > value_max:
		base = value_min
	elif base < value_min:
		base = value_max
	return base

func update_planet_sprite() -> void:
	$CanvasContainer/Middle/PlanetButton.texture_normal = planet_sprites[selected_sprite]
	$CanvasContainer/Middle/PlanetButton/Control.visible = !unlocked_sprites[selected_sprite]
	$CanvasContainer/Middle/PlanetButton/Control/BuySpriteButton.text = "Cost: " + str(sprite_prices[selected_sprite])
	print(unlocked_sprites[selected_sprite])

func _on_click_shop_1_1() -> void:
	purchase_upgrade(0, 0)
func _on_click_shop_1_2() -> void:
	purchase_upgrade(0, 1)
func _on_click_shop_1_3() -> void:
	purchase_upgrade(0, 2)
func _on_click_shop_2_1() -> void:
	purchase_upgrade(1, 0)
func _on_click_shop_2_2() -> void:
	purchase_upgrade(1, 1)
func _on_click_shop_2_3() -> void:
	purchase_upgrade(1, 2)
