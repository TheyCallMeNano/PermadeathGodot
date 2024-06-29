extends Control
## This script controls the buttons on the Class Selection Menu


## Assassin Class
func _on_rouge_pressed():
	global.classInt = 0
	global.className = "Assassin"
	get_tree().change_scene_to_file("res://Rooms/MainScene.tscn")

## Alchemist Class
func _on_alchemist_pressed():
	global.classInt = 1
	global.className = "Alchemist"
	get_tree().change_scene_to_file("res://Rooms/MainScene.tscn")
