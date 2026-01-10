extends Control


var score: int = 0
var score_increment: int = 1

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
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9
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
		score += score_increment
		$CanvasContainer/Middle/ScoreLabel.text = "Score: " + str(score)
	else:
		pass

func _cycle_planet_sprite_forward() -> void:
	selected_sprite = increment_clamped(selected_sprite, 0, 9)
	update_planet_sprite()

func _cycle_planet_sprite_backward() -> void:
	selected_sprite = increment_clamped(selected_sprite, 0, 9, -1)
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
	if !unlocked_sprites[selected_sprite]:
		pass
	print(unlocked_sprites[selected_sprite])
