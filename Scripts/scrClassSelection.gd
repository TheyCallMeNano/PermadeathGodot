extends Control



func _on_rouge_pressed():
	global.classInt = 0
	global.className = "Rouge"
	get_tree().change_scene_to_file("res://Rooms/MainScene.tscn")


func _on_alchemist_pressed():
	global.classInt = 1
	global.className = "Alchemist"
	get_tree().change_scene_to_file("res://Rooms/MainScene.tscn")
