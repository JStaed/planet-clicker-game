extends Control


var score: int = 0
var increment: int = 1

var selected_sprite: int = 0

var unlocked_sprites = [
	true, false, false, false, false, false, false, false, false, false
]

func _on_click_planet(): # Increments score by increment value when the planet is clicked
	score += increment
	$CanvasContainer/Middle/ScoreLabel.text = "Score: " + str(score)

func _cycle_planet_sprite_forward():
	selected_sprite = increment_clamped(selected_sprite, 0, 9)
	print(unlocked_sprites[selected_sprite])

func _cycle_planet_sprite_backward():
	selected_sprite = increment_clamped(selected_sprite, 0, 9, -1)
	print(unlocked_sprites[selected_sprite])

func increment_clamped(base: int, min: int, max: int, increment: int = 1) -> int:
	base += increment
	if base > max:
		base = min
	elif base < min:
		base = max
	return base
