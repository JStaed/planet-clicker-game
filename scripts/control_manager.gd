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
	selected_sprite += 1

func _cycle_planet_sprite_backward():
	selected_sprite -= 1
