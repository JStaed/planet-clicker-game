extends Control

const PRICE_RATIO = 0.2

var score: int = 0
var score_increment: int = 1
var score_per_second: int = 0

var selected_sprite: int = 0
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

var upgrade_levels = [
	0,
	0,
	0,
	0,
	0,
	0
]

var shop_1_prices = [
	11,
	12,
	13
]
var shop_2_prices = [
	21,
	22,
	23
]

var shop_1_upgrade = [
	1,
	10,
	50
]
var shop_2_upgrade = [
	1,
	5,
	10
]

func purchase_upgrade(upgradeID: int, shopID: int):
	if shopID == 0: # Shop 1
		if score >= shop_1_prices[upgradeID]:
			score -= shop_1_prices[upgradeID]
			shop_1_prices[upgradeID] = int(floor(shop_1_prices[upgradeID] + (shop_1_prices[upgradeID] * PRICE_RATIO)))
			upgrade_levels[upgradeID] += 1
			match upgradeID:
				0:
					$CanvasContainer/Left/ShopButton.text = "Satellite: lvl " + upgrade_levels[0] + " | Cost: " + shop_1_prices[upgradeID]
				1:
					$CanvasContainer/Left/ShopButton2.text = "Rover: lvl " + upgrade_levels[1] + " | Cost: " + shop_1_prices[upgradeID]
				2:
					$CanvasContainer/Left/ShopButton3.text = "Rocket: lvl " + upgrade_levels[2] + " | Cost: " + shop_1_prices[upgradeID]
			register_upgrade(upgradeID, shopID)
	elif shopID == 1: # Shop 2
		if score >= shop_2_prices[upgradeID]:
			score -= shop_2_prices[upgradeID]
			shop_2_prices[upgradeID] = int(floor(shop_2_prices[upgradeID] + (shop_2_prices[upgradeID] * PRICE_RATIO)))
			upgrade_levels[upgradeID] += 1
			match upgradeID:
				0:
					$CanvasContainer/Right/ShopButton.text = "Research Lab: lvl " + upgrade_levels[3] + " | Cost: " + shop_2_prices[upgradeID]
				1:
					$CanvasContainer/Right/ShopButton2.text = "Colony: lvl " + upgrade_levels[4] + " | Cost: " + shop_2_prices[upgradeID]
				2:
					$CanvasContainer/Right/ShopButton3.text = "City: lvl " + upgrade_levels[5] + " | Cost: " + shop_2_prices[upgradeID]
			register_upgrade(upgradeID, shopID)

func register_upgrade(upgradeID: int, shopID: int):
	if shopID == 0:
		score_per_second += shop_1_upgrade[upgradeID]
	elif shopID == 1:
		score_increment += shop_2_upgrade[upgradeID]
	$CanvasContainer/Middle/ScoreLabel.text = "Score: " + str(score)

func _on_click_planet() -> void: # Increments score by increment value when the planet is clicked
	if unlocked_sprites[selected_sprite]:
		score += score_increment * (1 + selected_sprite)
		$CanvasContainer/Middle/ScoreLabel.text = "Score: " + str(score)

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
		$CanvasContainer/Middle/ScoreLabel.text = "Score: " + str(score)
		update_planet_sprite()

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

# Shop buttons
func _on_click_shop_1_1() -> void:
	purchase_upgrade(0, 0)
func _on_click_shop_2_1() -> void:
	purchase_upgrade(1, 0)
func _on_click_shop_3_1() -> void:
	purchase_upgrade(2, 0)
func _on_click_shop_1_2() -> void:
	purchase_upgrade(0, 1)
func _on_click_shop_2_2() -> void:
	purchase_upgrade(1, 1)
func _on_click_shop_3_2() -> void:
	purchase_upgrade(2, 1)
# -----------
