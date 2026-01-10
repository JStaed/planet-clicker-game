extends Control


var score: int = 0
var score_increment: int = 1

var selected_sprite: int = 0

var unlocked_sprites = [
	true, false, false, false, false, false, false, false, false, false
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

func _on_click_planet(): # Increments score by increment value when the planet is clicked
	if unlocked_sprites[selected_sprite]:
		score += score_increment
		$CanvasContainer/Middle/ScoreLabel.text = "Score: " + str(score)
	else:
		pass

func _cycle_planet_sprite_forward():
	selected_sprite = increment_clamped(selected_sprite, 0, 9)
	print(unlocked_sprites[selected_sprite])

func _cycle_planet_sprite_backward():
	selected_sprite = increment_clamped(selected_sprite, 0, 9, -1)
	print(unlocked_sprites[selected_sprite])

func increment_clamped(base: int, value_min: int, value_max: int, increment: int = 1) -> int:
	base += increment
	if base > value_max:
		base = value_min
	elif base < value_min:
		base = value_max
	return base

func update_planet_sprite(spriteID: int):
	pass
